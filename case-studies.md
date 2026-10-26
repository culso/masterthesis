# Case study tracking sheet (`case-studies.ods`)

Tracks the eight case-study runs (see Research Approach in `01introduction.tex`): two configurations (baseline vs. `AGENTS.md` + Chakra UI skills) × three agents on Box Cipher, plus Claude Code on Route Cipher as a replication.

## Sheets

- **Overview**: one row per run in the planned run order. Columns from *Date* onwards are formulas that pull values from the run sheets; do not edit them by hand.
- **One sheet per run** (e.g. `Claude Box Setup`), filled in during and after the run.
- **Legend**: definitions of the intervention types, problem categories, and the done/abort criteria.

## Run sheet layout

Yellow cells are input fields. Grey cells are labels, and white cells hold formulas.

1. **Header (rows 3–20)**: run metadata: date, agent version, model and reasoning effort, local model details (OpenCode only), start commit, `AGENTS.md` hash, neutral branch name for the blind review, transcript file, start/end time, outcome, tokens, and cost. *Total duration* is calculated from start and end time.
2. **Prompt log (rows 24–73)**: one row per prompt. *Intervention type* (Initial / Report / Hint / Instruction / Manual fix), *Problem category*, *Setup used?*, *Builds OK* and *Lint OK* are dropdowns, and other values are rejected so that the counts in the Overview stay correct.
3. **Review (from row 76)**: reviewer, done checklist (Y/N), and the four evaluation criteria from `06evaluation.tex` (convention adherence, reuse of existing code, correctness, maintainability), each scored 1–5 with a comment. The average is calculated automatically.

## Notes

- Fill in the log while the run is going on. Transcripts and git history are the full record, and the log is the quick index into them.
- The Overview counts only the log rows 24–73. If a run needs more than 50 prompts, insert rows *inside* the log (not below it) so the formula ranges grow with it.
- The abort budget in the Legend (90 min or 25 prompts) is a placeholder; adjust it before the first run and keep it fixed afterwards.
