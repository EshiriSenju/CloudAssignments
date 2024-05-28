#!/bin/bash

# List of filenames
filenames=("file1.txt" "file2.txt" "image1.png" "document.pdf")

# Go through the list and print each filename
for filename in "${filenames[@]}"; do
    echo "$filename"
done
