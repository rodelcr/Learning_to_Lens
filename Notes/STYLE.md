# Prose style sheet — Learning to Lens

Written 2026-10-22 for the de-LLM writing pass. The target register is that of
the reference texts the chapters are built from: Narayan & Bartelmann (1997),
Congdon & Keeton (2018), Schneider, Ehlers & Falco (1992), Schneider, Kochanek
& Wambsganss (2006), Saha et al. (2024), Meneghetti (2021), and for the GR
chapters Carroll (2004). What follows is what those texts actually do on the
page, checked against `Reference_Texts/` (never quoted here beyond a phrase).

## How the source texts read

- **Continuous paragraphs.** Exposition is paragraphs of four to eight
  sentences. Lists appear only for genuinely enumerable things (the three
  contributions to a time delay, the four lens models of a chapter), never as a
  substitute for an argument and never as a chapter agenda.
- **First person plural, declarative.** "We now introduce", "It is convenient
  to define", "Therefore", "Hence", "From Fig. 5 we see that". The reader is
  never addressed as "you". No imperative "Let's".
- **Definitions in italics, once.** A new term is set in italics the first time
  it is defined ("commonly called the *lens plane*") and in roman thereafter.
  Bold is used for nothing in running text.
- **Sentences carry the logic.** Transitions are "therefore", "hence", "since",
  "so that", "in particular", "conversely". Not "Crucially", "Importantly",
  "Remarkably", "Note that" as a sentence opener, or "In other words" as a
  habit.
- **Parentheticals are parentheses or a subordinate clause.** The dash is rare:
  SEF and C&K use it perhaps once a page, for a true interruption. It is never a
  substitute for a comma or a colon, and never used in pairs to set off an
  aside that a comma pair would carry.
- **No evaluative adjectives about the mathematics.** The texts do not say a
  result is elegant, beautiful, remarkable, profound, or deep. They state it.
  (SEF does say "a very elegant method" once in 600 pages; that is the budget.)
- **No signposting of insight.** No "the key insight is", "the punchline",
  "takeaway", "what this means", "why this matters", "the bottom line".
  The sentence that would follow such a phrase is simply written.
- **Equations are part of sentences.** A display is introduced by a clause
  ending in a colon or by a sentence that runs into it, and the sentence
  continues after it ("where ξ is the distance from the lens center").
- **Chapter openers are prose.** C&K and N&B open a chapter with one or two
  paragraphs saying what is derived and from what. There is no bulleted plan,
  no "The plan is:", no bold terms announcing section contents.
- **Worked solutions read like the text.** N&B and C&K solutions are terse
  derivations: state what is computed, compute it, state the result, remark on
  its meaning in one sentence. No "Sanity check:", "Physically:",
  "Intuitively:" paragraph labels; the check is written as a sentence
  ("The limit *m* → 0 recovers eq. (3.4), as it must.").
- **Short declarative fragments are not used for effect.** No "Real lines of
  sight are not so tidy." No one-line paragraphs for emphasis.
- **Questions are rare.** A rhetorical question appears when the text genuinely
  poses a problem it is about to solve, at most once per chapter.

## What to change (the LLM tells found in this book, 2026-10-22 baseline)

| Pattern | Replace with |
|---|---|
| `---` dash pairs setting off an aside | parentheses, a comma pair, or a separate sentence |
| `---` before a trailing clause | a colon, a semicolon-free new sentence, or "which" |
| `\textbf{term}` in running text | `\emph{term}` at first definition only; roman afterwards |
| `\textbf{Label:}` paragraph lead-ins ("Classic error:", "Sanity check:", "Physically:") | a sentence that says the thing |
| "The plan is:" / "In this chapter we will:" + itemize | one prose paragraph |
| Itemize used for an argument or a derivation outline | paragraphs |
| "Let's", "Let us now", "you", "your" | "we", or restructure |
| "Note that", "Notice that", "It is worth noting", "Importantly", "Crucially", "Remarkably" | delete the opener; keep the content |
| "elegant", "beautiful", "profound", "deep", "remarkable", "striking", "powerful" (about mathematics) | delete the adjective |
| "key insight", "takeaway", "punchline", "bottom line", "boils down to", "why this matters", "what this means" | delete; write the statement |
| "In other words", "Put differently", "That is to say" more than once per section | delete; if the restatement adds nothing, delete the restatement |
| "simply", "essentially", "just", "merely", "basically" | delete |
| "This means that", "This tells us that" | "Therefore", "Hence", or restructure |
| Exclamation marks | full stops |
| One-sentence paragraphs for emphasis | fold into the neighbouring paragraph |
| Chains of three parallel noun phrases for rhythm ("X, Y, and Z" where one would do) | the one that matters |

## What never changes

- Mathematics: every `$…$`, `\[…\]`, `equation`, `align`, `gather`, `multline`
  block, byte for byte.
- Every number in the prose. If a number reads wrongly, report it; do not
  edit it (fact-critic rule: every changed number needs a `check[]`).
- `\label`, `\ref`, `\eqref`, `\cite*`, `\mathlink`, `\solnlink`, `\href`,
  `\annot`, figure/table environments and their captions' references.
- Box environments (`annotation`, `derivation`, `bridge`, `keybox`, `aside`)
  and their titles' meaning; the prose inside them is in scope. Author rules
  R1–R5 in `editions.tex` still apply.
- Section structure and headings. Exercise statements' content.
- Quotations from the source texts set in `quote` environments.

`Notes/prose_guard.py OLD NEW` asserts the invariants above mechanically;
`Notes/style_lint.sh FILE` counts the tells. Both must be run before a prose
commit, and the lint counts before/after are quoted in the commit message.

## Voice calibration by part

- **Part I (GR, Chapters 1–5)** follows Carroll: explanatory, first person
  plural, willing to say what a quantity "means", but in sentences, not boxes.
  Carroll's occasional lightness is tone, not a licence for fragments.
- **Parts II–III (Chapters 6–14)** follow N&B and C&K: compact, every sentence
  advances the derivation, definitions italicised once.
- **Part IV (Chapters 15–17)** follows Schneider, Kochanek & Wambsganss (2006):
  review-article register, slightly denser than Part II.
- **Part V (Chapters 18–25)** follows SEF and the recent literature
  (Schneider 2014/2019, Collett & Auger 2014): formal, index-heavy, careful
  about conventions; the one place where a numbered list of conventions is
  natural.
- **Annotation / derivation / bridge boxes** (annotated edition only) are
  the student's margin notes in the author's voice. Same rules; they may be
  more informal in content (a common error, a unit check) but not in diction.
