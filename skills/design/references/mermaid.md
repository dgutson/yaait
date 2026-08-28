# Diagrams in yaait

Mermaid, not PlantUML. The reason is operational rather than aesthetic: mermaid renders
natively in GitHub, in Claude Code artifacts, in most editors and in every markdown preview,
with no jar, no server, no Graphviz and no toolchain. PlantUML is more expressive and it is
not worth a dependency the reader has to install before they can see the design.

If the user prefers PlantUML, use it — the conventions below all transfer.

## What to produce

**Always:** a class diagram, plus a sequence diagram for the single most important flow. Both
are drawn at `design` **Step 1c**, before the elaboration questions, because a question asked
with nothing on screen is answered on intuition. They are revised at Step 5, not drawn again.

**When the condition holds:** a state diagram whenever anything has modes, phases or a
lifecycle — even when it feels too obvious to draw. Most defects live in state transitions,
and specifically in the transitions nobody drew. The diagram is where a missing transition
is visible as a gap instead of arriving later as a bug. This one is drawn at Step 5, because it
depends on decisions the elaboration steps only just settled.

**Never:** a diagram per component. Three diagrams a reader studies beat nine they scroll
past, and the point of the diagram is to be read.

## Conventions

- **Direction of dependency is the point of a class diagram.** Get the arrows right; a
  diagram with the right boxes and vague arrows says nothing.
- **Label every relationship.** An unlabelled line between two boxes is a decoration.
  `Board --> Store : persists via` carries the design; `Board --> Store` does not.
- **Label text is not free text.** Keep every label, note and message to letters, digits,
  spaces, commas and hyphens. Mermaid parses them: `;` `:` `#` `(` `"` variously break the
  block or silently swallow the rest of the label, and quoting is not a reliable escape.
  Rephrase — a comma, or two labels.
- **Show only what the design decides.** Getters, setters, trivial constructors and fields
  the reader can infer all cost attention and add nothing.
- **Name the invariant near the diagram, not in it.** Mermaid notes get unreadable fast;
  `DESIGN.md` has an invariants section for this.
- **Keep diagrams and prose consistent.** If they disagree, a reader believes the diagram.
  When the design changes, the diagram changes in the same edit.
- **Group by part, the same way the document does.** `DESIGN.md` nests its components under
  parts; a diagram that lists them flat makes the reader answer "what runs where" twice and get
  two different answers. `namespace` in a class diagram, `box ... end` in a sequence diagram.
- **`_` is the name separator**, as in `Server_Match`. Not `:` — it is on the list above of
  characters that break the block or swallow the rest of the label, and quoting does not rescue
  it.

### Grouping, and the two ways it fails

```mermaid
classDiagram
    namespace Server {
        class Match {
            -phase
            +apply(seat, command) Result
        }
        class Registry {
            +create(count) Match
        }
    }
    namespace Shared {
        class geometry {
            +fits(cells) bool
        }
    }
    Registry --> Match : owns
    Match --> geometry : validates placement with
```

**Relationships go outside the namespaces.** Declare the classes in their groups, then draw
every arrow after the last `}`. A `-->` written inside a `namespace` block is a **parse error**,
not a missing line — checked against mermaid 11.17.2, where the arrangement above parses and the
same diagram with `Registry --> Match : owns` moved inside the block fails on that line. Grouping
is also newer than the rest of this file's syntax, so it is a real case for the render check at
the end rather than a formality.

In a sequence diagram the same grouping is `box ... end`:

```mermaid
sequenceDiagram
    actor Player
    box Server side
    participant Match
    participant Board
    end
    Player->>Match: fire(target, cell)
```

**A one-word `box` title that is a colour name disappears.** Mermaid's syntax is
`box [colour] [description]`, so it reads the first token as a background colour when it
recognises one: a part named `Gold`, `Silver` or `Coral` becomes a coloured box with no title,
and it parses cleanly, so nothing tells you. Mermaid's own documented workaround is to force the
colour: `box transparent Gold`. Two-word titles — `Server side` — sidestep it entirely.

## Class diagram

```mermaid
classDiagram
    class Game {
        +start()
        +apply_move(Move) Result
    }
    class Board {
        -cells
        +is_legal(Move) bool
        +apply(Move)
    }
    class Store {
        +save(GameState)
        +load() GameState
    }
    class Renderer {
        +draw(GameState)
    }

    Game --> Board : owns
    Game --> Store : persists via
    Game --> Renderer : renders through
    Renderer ..> Board : reads only
```

Note what that last line encodes: `..>` for a read-only dependency, matching a `DESIGN.md`
prohibition that the renderer never mutates state. A diagram that can express a rule is
doing work.

## Sequence diagram

Draw the flow the spec's primary requirement describes. Include the failure branch — the
happy path is rarely where the design is wrong.

```mermaid
sequenceDiagram
    actor Player
    participant Game
    participant Board
    participant Store

    Player->>Game: apply_move(m)
    Game->>Board: is_legal(m)
    alt legal
        Board-->>Game: true
        Game->>Board: apply(m)
        Game->>Store: save(state)
        Store-->>Game: ok
        Game-->>Player: accepted
    else illegal
        Board-->>Game: false
        Game-->>Player: rejected, board unchanged
    end
```

The `else` branch is where the invariant "a rejected move leaves the board unchanged"
becomes checkable. Without it the diagram documents only the case that was going to work.

## State diagram

```mermaid
stateDiagram-v2
    [*] --> Setup
    Setup --> Playing : both players ready
    Playing --> Paused : pause
    Paused --> Playing : resume
    Playing --> Ended : win / loss / draw
    Paused --> Ended : quit
    Ended --> [*]
```

Two checks worth running on every state diagram, because they catch most of what these
diagrams are for:

1. **Every state must be reachable and leavable.** A state with no way out is a hang; a
   state with no way in is dead code.
2. **For every pair of states, ask what happens on the transition you did not draw.** What
   does `pause` do while `Ended`? What does a move arriving during `Setup` do? Those
   undrawn combinations are where the defects are, and the answer is either "impossible,
   and here is what makes it impossible" or a missing transition.

That second check is the highest-value thing in this file. Run it explicitly rather than by
eye.

## Entity / data diagrams

For a persisted format or schema, an ER diagram earns its place, because a persisted format
has a compatibility future and is among the most expensive things in a design to change:

```mermaid
erDiagram
    GAME ||--o{ MOVE : contains
    GAME {
        string id PK
        string status
    }
    MOVE {
        string game_id FK
        int ordinal
        string notation
    }
```

## Checking that it renders

Malformed mermaid fails as a code block full of text, which is worse than no diagram
because it looks like an error in the design rather than in the syntax. Common causes:
punctuation in a label (above — quoting it is not the fix), a stray blank line inside the
block, participant names with spaces, and `-->` used where the diagram type wants `->>`.

If a diagram is non-trivial, render it once before finishing — Claude Code artifacts render
mermaid natively, so publishing the design as an artifact is a cheap check as well as a
readable deliverable.
