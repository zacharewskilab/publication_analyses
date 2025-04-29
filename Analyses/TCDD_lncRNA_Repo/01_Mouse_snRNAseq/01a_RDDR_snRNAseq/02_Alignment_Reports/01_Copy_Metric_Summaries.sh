#!/bin/bash

# Define source base directory and destination directory
SOURCE_BASE="/mnt/gs21/scratch/cholicog/RDDR_Output"
DEST_DIR="./Metric_Summaries"

# Create the destination directory if it doesn't exist
mkdir -p "$DEST_DIR"

# Loop through each L* directory and copy/rename the specified files
for dir in "$SOURCE_BASE"/L*/; do
    if [[ -d "$dir" ]]; then
        # Extract the directory name (e.g., L123)
        DIR_NAME=$(basename "$dir")
        
        # Define source file paths
        WEB_SUMMARY="$dir/outs/web_summary.html"
        METRICS_SUMMARY="$dir/outs/metrics_summary.csv"
        
        # Define destination file paths with new names
        RENAMED_WEB_SUMMARY="$DEST_DIR/${DIR_NAME}_web_summary.html"
        RENAMED_METRICS_SUMMARY="$DEST_DIR/${DIR_NAME}_metrics_summary.csv"
        
        # Copy and rename files if they exist
        if [[ -f "$WEB_SUMMARY" ]]; then
            cp "$WEB_SUMMARY" "$RENAMED_WEB_SUMMARY"
        fi
        if [[ -f "$METRICS_SUMMARY" ]]; then
            cp "$METRICS_SUMMARY" "$RENAMED_METRICS_SUMMARY"
        fi
    fi
done

# List copied files to confirm
echo "Copied and renamed files:"
ls "$DEST_DIR"
