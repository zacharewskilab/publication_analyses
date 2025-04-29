#!/bin/bash

# Define source and destination directories
source_dir="/mnt/gs21/scratch/cholicog/Rat/Alignment_Data_LiftOver"
dest_dir="STAR_Output"

# Create the destination directory
mkdir $dest_dir

# Copy all _ReadsPerGene.out.tab files from the source to the destination directory
cp ${source_dir}/*_ReadsPerGene.out.tab ${dest_dir}/

echo "All _ReadsPerGene.out.tab files have been copied to ${dest_dir}"