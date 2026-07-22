# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository purpose

This is Michael Heep's master's thesis (LaTeX), working title: "Evaluation and Improvement of LLMs (AI Agents) Contribution to Large Software Projects with CrypTool as an Example." The thesis investigates how well LLM coding agents (Claude Code, Codex, OpenCode, ...) can contribute to a large existing software project (CrypTool-Online), via qualitative multi-case-study case studies.

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
Note: `count.sh` currently expects the thesis to be split into `01introduction.tex`, `02pascal.tex`, `03grep.tex`, `04conclusion.tex` — these files do not exist yet since all content currently lives in `main.tex`. If/when the thesis is split into per-section files, keep `count.sh`'s `sections` array and any `\input`/`\include` in `main.tex` in sync.

Generated build artifacts (`*.aux`, `*.bbl`, `*.bcf`, `*.blg`, `*.log`, `*.xml`, `*.toc`) are gitignored; only `main.pdf` is committed intentionally.

## Document structure

- `main.tex` — the entire thesis document (title page, abstract, all sections). Uses KOMA-Script `scrartcl`, `biblatex`/`biber` for citations, `cleveref` for smart references, Libertinus fonts.
- `references.bib` — bibliography database (currently empty).
- `resources/` — university logo/branding PDFs used on the title page.

Current top-level section outline in `main.tex` (see inline `%` comments there for detailed, evolving notes on planned subsection content — these comments are the closest thing to a living outline/TODO list and should be consulted before restructuring):
1. Introduction (motivation/problem statement, research questions, limitations, structure)
2. Background and Related Work
3. Foundations (LLMs, Agentic AI, Skills and Tooling, requirements in the CTO dev project)
4. Development of ... (planned: building the customized agent setup/config)
5. Implementation and Case Studies (experimental setup, then one case study subsection per agent: Claude Code, Codex, OpenCode)
6. Evaluation (cross-agent and cross-approach comparisons)
7. Conclusion and Future Work

Many sections are currently placeholders with only commented-out planning notes (`% TODO`, `%` bullet outlines) and no prose yet — check for these before assuming a section is finished.

## Working conventions

- Author is Michael Heep; examiners are Prof. Dr. Bernhard Esslinger and Prof. Dr. Roland Wismüller.
- Abstract/Kurzzusammenfassung: German summary (`Kurzzusammenfassung`) and English `Abstract` are both required near the top of the document, currently both TODO.
- The thesis references "CTO" as shorthand for CrypTool-Online throughout planning comments.
- Scope is deliberately limited: not a full N-apps x M-approaches x K-agents matrix, but a sampled qualitative multi-case-study with Claude Code as the primary deep case study and Codex/OpenCode treated as shallower "dry run" comparisons.
