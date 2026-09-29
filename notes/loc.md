# Lines of Code — CTO Apps vs. Rest of Site

---

# LoC Breakdown

Total tracked source: **122,865 lines** (excludes lockfiles, images, and other binaries).

## CTO Apps vs. Rest of Site

| Part                                                                               |  Lines | Share |
| ---------------------------------------------------------------------------------- | -----: | ----: |
| `ctoapps/` (mini-apps)                                                             | 82,500 |   67% |
| Rest of site (`pages/`, `common/`, `app/`, `chakra-ui/`, `webpack/`, `docs/`, ...) | 40,365 |   33% |

## By Filetype

### `ctoapps/`

| Ext  |  Lines |
| ---- | -----: |
| .jsx | 47,094 |
| .js  | 20,569 |
| .mdx |  8,111 |
| .tsx |  5,488 |
| .ts  |    434 |
| .py  |    646 |
| .css |     75 |

### Rest of site

| Ext  |  Lines |
| ---- | -----: |
| .jsx | 15,823 |
| .mdx |  7,735 |
| .tsx |  5,002 |
| .md  |  4,688 |
| .js  |  4,157 |
| .ts  |    967 |
| .py  |     55 |

## Largest Mini-Apps

| App                              |  Lines |
| -------------------------------- | -----: |
| homophonic-substitution-analyzer | 18,175 |
| rsa-visual                       | 12,566 |
| 2fa                              |  7,853 |
| openssl                          |  7,169 |
| kyber                            |  5,262 |
| rsa-didactic                     |  4,939 |

> Two-thirds of the codebase lives under `ctoapps/`. Five apps (homophonic analyzer, rsa-visual, 2fa, openssl, kyber) account for over
> half of that subtree.

### Exclude lockfiles/binaries pattern (reused below)

```bash
EXCL='\.(lock|json|svg|png|jpg|jpeg|gif|ico|woff|woff2|ttf|eot|pdf|mp4|pptx|csv|pem|crt|lnk|wasm)$'
```

### Overall total

```bash
git ls-files | grep -vE "$EXCL" | xargs wc -l 2>/dev/null | tail -1
```

### CTO apps vs rest of site

```bash
echo "ctoapps total:"
git ls-files ctoapps | grep -vE "$EXCL" | xargs wc -l 2>/dev/null | tail -1

echo "rest of site total:"
git ls-files | grep -v '^ctoapps/' | grep -vE "$EXCL" | xargs wc -l 2>/dev/null | tail -1
```

### By filetype, ctoapps

```bash
echo "=== ctoapps by ext ==="
for e in ts tsx js jsx mdx py css md; do
  n=$(git ls-files "ctoapps/*.$e" | xargs wc -l 2>/dev/null | tail -1 | awk '{print $1}')
  echo "$e: ${n:-0}"
done
```

### By filetype, rest of site

```bash
echo "=== non-ctoapps by ext ==="
for e in ts tsx js jsx mdx py css md; do
  n=$(git ls-files "*.$e" | grep -v '^ctoapps/' | xargs wc -l 2>/dev/null | tail -1 | awk '{print $1}')
  echo "$e: ${n:-0}"
done
```

### Per-app breakdown, sorted descending

```bash
echo "=== ctoapps subdir breakdown ==="
for d in ctoapps/*/; do
  n=$(git ls-files "$d" | grep -vE "$EXCL" | xargs wc -l 2>/dev/null | tail -1 | awk '{print $1}')
  echo "${n:-0} $d"
done | sort -rn
```

### Notes

> - `git ls-files` only counts tracked files, so it naturally skips node_modules/, \_site/, build output, etc.
> - If a new file extension becomes significant (e.g. someone adds .svelte), add it to the for e in ... lists.
> - If a new asset type shows up that should be excluded, add it to $EXCL.
> - Sorting the per-app breakdown (last block) makes it easy to spot the new "biggest apps" without eyeballing.
