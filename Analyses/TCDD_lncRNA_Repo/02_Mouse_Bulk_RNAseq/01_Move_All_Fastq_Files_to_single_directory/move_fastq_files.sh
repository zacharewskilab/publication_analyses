#!/bin/bash

# Destination directory
DEST_DIR="/mnt/gs21/scratch/cholicog/Mouse/RAW_FASTQ/Consolidated"

# Create the destination directory if it doesn't exist
mkdir -p "$DEST_DIR"

# List of source directories
SOURCE_DIRS=(
    "/mnt/gs21/scratch/cholicog/Mouse/RAW_FASTQ/P161_L01"
    "/mnt/gs21/scratch/cholicog/Mouse/RAW_FASTQ/P161_L02"
    "/mnt/gs21/scratch/cholicog/Mouse/RAW_FASTQ/P161_L03"
    "/mnt/gs21/scratch/cholicog/Mouse/RAW_FASTQ/P161_L07"
    "/mnt/gs21/scratch/cholicog/Mouse/RAW_FASTQ/P161_L08"
    "/mnt/gs21/scratch/cholicog/Mouse/RAW_FASTQ/P161_L11"
    "/mnt/gs21/scratch/cholicog/Mouse/RAW_FASTQ/P161_L12"
    "/mnt/gs21/scratch/cholicog/Mouse/RAW_FASTQ/P161_L13"
    "/mnt/gs21/scratch/cholicog/Mouse/RAW_FASTQ/P161_L15"
    "/mnt/gs21/scratch/cholicog/Mouse/RAW_FASTQ/P161_L16"
    "/mnt/gs21/scratch/cholicog/Mouse/RAW_FASTQ/P161_L17"
    "/mnt/gs21/scratch/cholicog/Mouse/RAW_FASTQ/P161_L18"
    "/mnt/gs21/scratch/cholicog/Mouse/RAW_FASTQ/P161_L19"
    "/mnt/gs21/scratch/cholicog/Mouse/RAW_FASTQ/P161_L20"
    "/mnt/gs21/scratch/cholicog/Mouse/RAW_FASTQ/P161_L21"
    "/mnt/gs21/scratch/cholicog/Mouse/RAW_FASTQ/P161_L22"
    "/mnt/gs21/scratch/cholicog/Mouse/RAW_FASTQ/P161_L24"
    "/mnt/gs21/scratch/cholicog/Mouse/RAW_FASTQ/P161_L25"
    "/mnt/gs21/scratch/cholicog/Mouse/RAW_FASTQ/P161_L27"
    "/mnt/gs21/scratch/cholicog/Mouse/RAW_FASTQ/P161_L28"
    "/mnt/gs21/scratch/cholicog/Mouse/RAW_FASTQ/P161_L29"
    "/mnt/gs21/scratch/cholicog/Mouse/RAW_FASTQ/P161_L34"
    "/mnt/gs21/scratch/cholicog/Mouse/RAW_FASTQ/P161_L35"
    "/mnt/gs21/scratch/cholicog/Mouse/RAW_FASTQ/P161_L36"
    "/mnt/gs21/scratch/cholicog/Mouse/RAW_FASTQ/P161_L37"
    "/mnt/gs21/scratch/cholicog/Mouse/RAW_FASTQ/P161_L38"
    "/mnt/gs21/scratch/cholicog/Mouse/RAW_FASTQ/P161_L39"
    "/mnt/gs21/scratch/cholicog/Mouse/RAW_FASTQ/P161_L40"
    "/mnt/gs21/scratch/cholicog/Mouse/RAW_FASTQ/P161_L41"
    "/mnt/gs21/scratch/cholicog/Mouse/RAW_FASTQ/P161_L42"
    "/mnt/gs21/scratch/cholicog/Mouse/RAW_FASTQ/P161_L43"
    "/mnt/gs21/scratch/cholicog/Mouse/RAW_FASTQ/P161_L44"
    "/mnt/gs21/scratch/cholicog/Mouse/RAW_FASTQ/P161_L47"
    "/mnt/gs21/scratch/cholicog/Mouse/RAW_FASTQ/P161_L48"
    "/mnt/gs21/scratch/cholicog/Mouse/RAW_FASTQ/P161_L49"
    "/mnt/gs21/scratch/cholicog/Mouse/RAW_FASTQ/P161_L50"
    "/mnt/gs21/scratch/cholicog/Mouse/RAW_FASTQ/P161_L51"
    "/mnt/gs21/scratch/cholicog/Mouse/RAW_FASTQ/P161_L52"
    "/mnt/gs21/scratch/cholicog/Mouse/RAW_FASTQ/P161_L53"
    "/mnt/gs21/scratch/cholicog/Mouse/RAW_FASTQ/P161_L54"
)

# Loop through source directories
for dir in "${SOURCE_DIRS[@]}"; do
    echo "Processing directory: $dir"
    # Find all .fq.gz files and copy them to the destination directory
    find "$dir" -name "*.fq.gz" -exec cp {} "$DEST_DIR" \;
done

echo "All FASTQ files have been copied to $DEST_DIR"
