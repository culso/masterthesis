# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository purpose

This is Michael Heep's master's thesis (LaTeX), title: "Evaluating and Improving Software Development Processes in Large-Scale Projects Using LLM-Based AI Agents: A Case Study of CrypTool." The thesis investigates how well LLM coding agents (Claude Code, Codex, OpenCode, ...) can contribute to a large existing software project (CrypTool-Online), via a qualitative multi-case study.

## Build commands

Build the PDF (runs pdflatex -> biber -> pdflatex -> pdflatex):
```
./build.sh main.tex
```
Add `-v` for verbose/full compiler output; without it, only warnings and errors are shown.

Word count per section (requires `detex`):
```
./count.sh
```
`count.sh` has a hard-coded `sections` array listing the per-section `.tex` files. When adding, removing, or renaming a section file, update both that array and the `\include` list in `main.tex`.

Generated build artifacts (`*.aux`, `*.bbl`, `*.bcf`, `*.blg`, `*.log`, `*.xml`, `*.toc`) are gitignored; only `main.pdf` is committed intentionally.

## Document structure

- `main.tex` — preamble, title page, Kurzzusammenfassung/Abstract, table of contents, and one `\include` per section file. Uses KOMA-Script `scrartcl`, `biblatex`/`biber` for citations, `cleveref` for smart references, Libertinus fonts.
- One file per top-level section, included in this order:
  1. `01introduction.tex` — Introduction (motivation/problem statement, research questions, limitations, structure)
  2. `02background.tex` — Background and Related Work
  3. `03foundations.tex` — Foundations (LLMs, Agentic AI, Skills and Tooling, requirements in the CTO dev project)
  4. `04development.tex` — Developing an Agent Setup for CrypTool-Online (the customized agent configuration: instruction files, skills, tools)
  5. `05implementation.tex` — Implementation and Case Studies (experimental setup, then one case study subsection per agent: Claude Code, Codex, OpenCode)
  6. `06evaluation.tex` — Evaluation (cross-agent and cross-approach comparisons)
  7. `07conclusion.tex` — Conclusion and Future Work
- `references.bib` — bibliography database (surveys, papers on agent configuration, benchmarks). `\printbibliography` in `main.tex` is still commented out, so citations resolve to numbers but no reference list is printed yet.
- `notes/` — working notes in Markdown, not part of the build: `findings.md` (observed agent behavior during experiments), `literatureResearch.md` (reading list), `llms.md` (overview of vendors/models/agents), `userReports.md` (reports from other CTO developers on their agent usage, partly in German).
- `resources/` — university logo/branding PDFs used on the title page.

Section files are wrapped in `\include`, so each starts on a new page and must not contain the preamble or `\begin{document}`.

Inline `%` comments in the section files hold detailed, evolving notes on planned subsection content. They are the closest thing to a living outline/TODO list and should be consulted before restructuring. Many sections are still placeholders with only these commented-out planning notes and no prose yet — check for this before assuming a section is finished.

## Working conventions

- Author is Michael Heep; examiners are Prof. Dr. Bernhard Esslinger and Prof. Dr. Roland Wismüller.
- Abstract/Kurzzusammenfassung: German summary (`Kurzzusammenfassung`) and English `Abstract` are both required near the top of `main.tex`, currently both TODO. Write them last, since they summarise results.
- The thesis references "CTO" as shorthand for CrypTool-Online throughout planning comments.
- Scope is deliberately limited: not a full N-apps x M-approaches x K-agents matrix, but a sampled qualitative multi-case-study with Claude Code as the primary deep case study and Codex/OpenCode treated as shallower "dry run" comparisons.
- When writing prose, keep the existing `%` planning comments and write beneath them; remove them only once the section they describe is done.
