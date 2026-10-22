# Lines of code of cryptool.org for the thesis

Notes from 2026-10-22 on how to count and cite the size of the codebase.

## Counting decisions

- **Tool:** cloc 2.10, run directly on a commit so that only tracked files count.
- **Snapshot:** commit `9d297a173fde8db3558cfd6a65e8ec363420fcff` (2026-10-20).
- **Definition:** physical source lines of code, i.e. no blank lines and no comment lines.
- **Included:** JSX, JavaScript (incl. `.mjs`), TypeScript (incl. `.tsx`), Python, CSS. Tests are included.
- **Excluded:** `chakra-ui/components/` (third-party snippets installed with `npx @chakra-ui/cli snippet add`), JSON (incl. `package-lock.json`), SVG, CSV, YAML, Markdown and text files.
- **Reported separately:** MDX content pages, since they are content rather than code.

## Results

| Language   | Files |  Blank | Comment |       Code |
| ---------- | ----: | -----: | ------: | ---------: |
| JSX        |   403 |  6,526 |   5,212 |     51,221 |
| JavaScript |   217 |  2,739 |   3,841 |     20,197 |
| TypeScript |    87 |    741 |     625 |      6,887 |
| Python     |     9 |    136 |     168 |        397 |
| CSS        |     1 |      5 |       0 |         70 |
| **Total**  |   717 | 10,147 |   9,846 | **78,772** |

- Of the total, 32 test files hold 8,653 lines, so the code without tests is about 70,100 lines.
- The excluded Chakra snippets are 54 files with 3,205 lines.
- The 312 MDX pages hold 10,584 non-blank lines. cloc treats MDX as Markdown and has no comment column for it, so this number is not comparable to the code count.

Command:

```sh
cloc 9d297a17 --include-lang=JavaScript,JSX,TypeScript,Python,CSS \
     --fullpath --not-match-d='chakra-ui/components'
```

## Text for the thesis

The body gives the rounded number, and a footnote holds the details. No appendix for now.

> The code base comprises approx. 79,000 source lines of code.¹

> ¹ Physical lines excluding blank lines and comments, counted with cloc 2.10 on commit `9d297a17` (2026-10-20) of the cryptool.org repository; tests (approx. 8,700 lines) included; third-party UI snippets and data files excluded. The 312 MDX content pages, which hold approx. 10,600 non-blank lines, are not included in this figure.

## Open points

- Get a persistent identifier for the commit: a Software Heritage ID (`swh:1:rev:...`) or a Zenodo DOI from a GitHub release. Use it in the footnote or bibliography next to the hash, or in place of it.
