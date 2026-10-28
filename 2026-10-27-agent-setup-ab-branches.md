# Agent setup: ma-setup and ma-base branches

**Date:** 2026-10-27 (session started 2026-10-26)
**Repository:** `culso/cryptool.org`
**Branches:** `ma-setup` (treatment arm), `ma-base` (control arm), both based on `main` 6ed00c72 and pushed to origin

## Goal

Improve the coding-agent setup for students who build CTO apps (CrypTool-Online mini-apps) with coding
agents. The setup consists of a lean AGENTS.md plus skills and MCP servers for Claude Code, OpenAI Codex
and OpenCode, with the rationale backed by scientific sources. Then prepare an A/B test: an agent with the
setup (`ma-setup`) against an agent with no instructions at all (`ma-base`).

## Decisions

- **Supported agents:** Claude Code, Codex and OpenCode. Rejected: GitHub Copilot (dropped on request).
- **A lean core plus skills:** AGENTS.md holds only what an agent can't find out from the code. Procedures
  go into skills that load on demand. Rejected: one large AGENTS.md (long context files lower the success
  rate and raise costs, see Gloaguen et al.).
- **One copy of each skill in `.agents/skills/`, linked relatively into `.claude/skills/`.** Codex and
  OpenCode read `.agents/skills/`, Claude Code reads `.claude/skills/`. Rejected: duplicated folders, and
  asking at project start which agent will be used. OpenCode may list skills twice; the workaround is
  `OPENCODE_DISABLE_CLAUDE_CODE_SKILLS=1`.
- **Session logs as an opt-in skill** (`session-log`, `disable-model-invocation: true`).
- **MCP servers:** Chakra UI (`@chakra-ui/react-mcp@2.1.1`) and Playwright (`@playwright/mcp@0.0.83
  --browser chromium --isolated`), pinned in `.mcp.json`, `opencode.json` and `.codex/config.toml`.
  - Chrome for Testing stays the default, even though Google Chrome is now installed: it is reproducible,
    needs no admin rights and is separate from the personal profile.
  - A personal override is possible with
    `claude mcp add --scope local playwright -- npx -y @playwright/mcp@0.0.83 --isolated`.
- **Mention both Next.js routers.** The project is migrating; `app/` has only the redirect and the
  search routes so far.
- **Compatibility with CrypTool desktop programs is not mandatory.**
- **Commit subjects aim for about 50 characters, with no fixed cap.**
- **Only the agent setup changes.** Errors found in `docs/` become follow-ups.
- **The CI format check skips symbolic links.** Prettier exits 2 on symlinks passed as explicit paths, and
  `.prettierignore` doesn't help. Rejected: dropping the links.
- **`ma-base` removes `AGENTS.md` and `CLAUDE.md`** for the most contrastive result, i.e. the "no context
  file" condition of Gloaguen et al. Rejected: keeping main's generic AGENTS.md. That would measure the
  setup against the status quo; `main` itself can serve as an optional third arm.

## Changes

`ma-setup`, 27 files changed, about 3000 lines added:

- `9fe8ad5e Add Chakra UI agent skills`: `chakra-ui-builder` and `chakra-ui-refactor` (installed with
  `npx skills add`), plus `skills-lock.json`.
- `1b91b7c4 Add CTO app agent skills`:
  - `new-cto-app`: 10 steps, with references for the skeleton, the `ctoapps.json` entry and a catalogue
    of reusable parts with usage counts;
  - `cto-texts`: English and German texts and the correct names;
  - `cto-app-check`: static checks, browser checks, conventions, unusual input, and a report;
  - `session-log`;
  - `.agents/logs/README.md`.
- `9b35a340 Add opt-in MCP configs for Claude Code, Codex and OpenCode`: the three config files plus
  `.agents/README.md` (setup per agent, how to prompt, rationale, 14 sources).
- `47bfe256 Rewrite AGENTS.md for CTO app development`: AGENTS.md (224 lines), with "reuse before you
  build" first, conventions, the correct names ("CrypTool", "CrypTool-Online") and "ask if in doubt".
  `.gitignore` now ignores `.claude/settings.local.json`.
- `80319322 Skip symbolic links in the CI format check`: `.github/workflows/development.yml`.

`ma-base`:

- `bf0841b6 Remove agent instructions for the baseline`: deletes `AGENTS.md` and `CLAUDE.md`. Nothing else
  needed removing, because `main` has no skills or MCP configs.

## Verification

- The skeletons in `new-cto-app` pass Prettier, ESLint and Jest. The file references in all skills were
  checked with a script.
- The CI symlink fix was tested with a passing and a failing format check.
- Dry run with Claude Code in plan mode (Affine cipher), with 27 turns, about $1.84 and about 5 minutes:
  - it loaded `new-cto-app` first, and both MCP servers connected;
  - it reused the option cards and `primeTools` `gcd`/`modInverse`;
  - it planned texts in English and German, the registry entry, the icon and tests;
  - it found a real bug: `MultiplicativeAlgorithm.js` hardcodes the inverses for m = 26.
- `opencode debug config` confirms that the project config is read.
- **Not checked:** Codex (not installed), a live OpenCode session (duplicate skills, MCP start), the browser
  part of `cto-app-check`, and symlinks on Windows.

## A/B test protocol

1. **Use a fresh single-branch clone per run,** outside `~/Projects/cto/`. Never use linked worktrees:
   in a worktree without `.claude/skills`, Claude Code loads the main checkout's skills.
   ```sh
   git clone --single-branch --branch ma-setup git@github.com:culso/cryptool.org.git ~/ab-runs/setup-1
   cd ~/ab-runs/setup-1 && git switch -c ab/setup-1 && npm ci
   ```
   The base arm works the same way with `ma-base`.
   - **Optional template folder per arm** to save `npm ci` time: copy it per run with `cp -a`, and never
     start an agent inside the template.
2. **Never work on `ma-setup` or `ma-base` themselves;** they are the fixed starting points. Pushing run
   branches is optional.
3. **Keep user-level extras identical in both arms or switch them off.** Disable `~/.agents/skills/find-skills`
   for the test, and record in the protocol the user-level skills, plugins, claude.ai connectors and
   Claude in Chrome.
4. **Setup arm only:** install the Playwright browser once with
   `npx -y @playwright/mcp@0.0.83 install-browser chrome-for-testing` and approve the project MCP servers.
5. **Keep the conditions fixed:** the same agent, model, prompt and plan-approval policy, and at least
   3 runs per arm.
   - **Measure** the `cto-app-check` rubric, the number of corrective follow-ups, tokens and time, and the
     lint and test results.
   - **Keep the rubric** outside both clones, and never let it into a base run.
6. **Rate the diffs blind:** `git diff ma-setup...ab/setup-1 > ~/ab-ratings/run-07.diff`. Keep the mapping
   from neutral name to run in a separate file.

## Open items

- Run the browser part of `cto-app-check` once.
- Test Codex and a live OpenCode session.
- Check the CI "Code style" job on the first PR from `ma-setup`.
- Follow-up bug: the hardcoded inverses for m = 26 in `MultiplicativeAlgorithm.js`.
- Follow-ups for errors in `docs/` (not part of this work).

## Where to find more

- The full transcript (JSON lines):
  `~/.claude/projects/-home-heepm-Projects-cto-cryptool-org/0754e28d-c5b2-4a0b-a312-923833926b74.jsonl`
- The dry-run plan (a possible baseline artifact): `~/.claude/plans/plan-a-new-cto-keen-scone.md`
- The rationale and sources: `.agents/README.md` on `ma-setup`
