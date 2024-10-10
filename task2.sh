#!/bin/bash

cd dataset1

grep -c "sample" file* | grep -E ":1$" | cut -d: -f1 | xargs grep -c "CSC510" | grep -E ":[3-9]$" | gawk -F: '{print $1, $2}' | gawk '{cmd = "wc -c " $1 " | awk \047{print $1}\047"; cmd | getline size; close(cmd); print $1, $2, size}' | sort -k2,2nr -k3,3nr | sed 's/file_/filtered_/' | gawk '{print $1}'
