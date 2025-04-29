#!/bin/bash

# Set the directory
sample_dir="/mnt/gs21/scratch/cholicog/Mouse/RAW_FASTQ/Consolidated"

cp -r "${sample_dir}/Pre-Trim_FastQC" .
cp -r "${sample_dir}/Post-Trim_FastQC" .
cp -r "${sample_dir}/QC_and_Trim_Reports" .

