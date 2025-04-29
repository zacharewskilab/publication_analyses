#!/bin/bash

# Define source and destination directories
SOURCE_DIR="/mnt/gs21/scratch/cholicog/RDDR_snRNAseq"
DEST_DIR="./Reports"

# Create the destination directory if it doesn't exist
mkdir -p "$DEST_DIR"

# Copy all files matching *SLURM* from source to destination
cp "$SOURCE_DIR"/*SLURM* "$DEST_DIR"

# List copied files to confirm
echo "Copied files:"
ls "$DEST_DIR"
