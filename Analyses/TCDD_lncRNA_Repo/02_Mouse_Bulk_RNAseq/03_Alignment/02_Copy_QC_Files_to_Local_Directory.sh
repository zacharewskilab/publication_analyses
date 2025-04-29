#!/bin/bash

mkdir ./Reports
mkdir ./Tab_Files

# Set the directory
sample_dir="/mnt/gs21/scratch/cholicog/Mouse/Alignment_Data/"

cp ${sample_dir}*.out ./Reports
cp ${sample_dir}*.err ./Reports
cp ${sample_dir}*.tab ./Tab_Files

