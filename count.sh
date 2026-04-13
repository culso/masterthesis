#!/bin/bash

sections=(01introduction 02pascal 03grep 04conclusion)
section_words=()
total=0

# Calculate word count for each section and total
for section in "${sections[@]}"; do
    count=$(detex ${section}.tex | wc -w)
    section_words+=("$count")
    total=$((total + count))
done

echo "Word count per section (with percentage of total):"
for i in "${!sections[@]}"; do
    percent=$(awk "BEGIN {printf \"%.1f\", (${section_words[$i]} / $total) * 100}")
    echo "${sections[$i]}: ${section_words[$i]} words (${percent}%)"
done
echo "Total word count: $total"
