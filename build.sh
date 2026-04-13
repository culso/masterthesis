#!/bin/bash

# Colors
RED="\033[1;31m"
BLUE="\033[1;34m"
NC="\033[0m"  # No color / reset

VERBOSE=0
FILES=()

# Parse arguments
for arg in "$@"; do
    if [ "$arg" = "-v" ]; then
        VERBOSE=1
    else
        FILES+=("$arg")
    fi
done

# Ensure at least one file is provided
if [ "${#FILES[@]}" -eq 0 ]; then
    echo "Usage: $0 [-v] file.tex"
    exit 1
fi

FILE="${FILES[0]}"
BASENAME="${FILE%.tex}"

show_warnings() {
    while IFS= read -r line; do
        echo -e "${RED}[WARN]${NC} $line"
    done
}

run_step() {
    STEP_NAME="$1"
    COMMAND="$2"
    FILTER="$3"  # optional filter regex

    echo -e "${BLUE}Step: $STEP_NAME${NC}"

    if [ "$VERBOSE" -eq 1 ]; then
        eval "$COMMAND"
    else
        if [ -n "$FILTER" ]; then
            eval "$COMMAND" 2>&1 | grep -E "$FILTER" | show_warnings
        else
            # If no filter, just discard output
            eval "$COMMAND" >/dev/null 2>&1
        fi
    fi
}

# Compile steps
run_step "pdflatex (first pass)" "pdflatex -interaction=nonstopmode \"$FILE\"" "^(LaTeX Warning|! )"
run_step "biber" "biber \"$BASENAME\"" ".*Warning.*|.*ERROR.*"
run_step "pdflatex (second pass)" "pdflatex -interaction=nonstopmode \"$FILE\"" "^(LaTeX Warning|! )"
run_step "pdflatex (final pass)" "pdflatex -interaction=nonstopmode \"$FILE\"" "^(LaTeX Warning|! )"

echo -e "${BLUE}Build finished.${NC}"
