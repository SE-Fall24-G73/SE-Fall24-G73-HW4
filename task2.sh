#!/bin/bash
DATASET_DIR="dataset1"

# a: List files containing "sample" and at least 3 occurrences of "CSC510"
echo "a: List files containing "sample" and at least 3 occurrences of "CSC510""
grep -rl "sample" "$DATASET_DIR" | while read -r file; do
    count=$(grep -o "CSC510" "$file" | wc -l)
    if [ "$count" -ge 3 ]; then
        echo "Occurrences: $count, File: $file" 
    fi
done

# b: Sorting files in descending order by occurrences of "CSC510" and break ties using file size
echo -e "b: Sorting files in descending order by occurrences of "CSC510" and break ties using file size"
grep -rl "sample" "$DATASET_DIR" | while read -r file; do
    count=$(grep -o "CSC510" "$file" | wc -l)
    if [ "$count" -ge 3 ]; then
        size=$(stat -c%s "$file") 
        echo "$count $size $file"  
    fi
done | gawk '{print $1, $2, $3}' | sort -k1,1nr -k2,2nr  # Use gawk to format and sort

# c: Renaming files: “file_” with “filtered_”
echo -e "c: Renaming files: “file_” with “filtered_”"
grep -rl "sample" "$DATASET_DIR" | while read -r file; do
    count=$(grep -o "CSC510" "$file" | wc -l)
    if [ "$count" -ge 3 ]; then
        echo "$count $file"  
    fi
done | sort -k1,1nr -k2,2n | awk '{sub(/file_/, "filtered_", $2); print $2}'
