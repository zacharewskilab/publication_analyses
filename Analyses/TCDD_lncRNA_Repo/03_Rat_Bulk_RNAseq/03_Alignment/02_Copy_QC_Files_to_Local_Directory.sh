#!/bin/bash

mkdir ./Reports
mkdir ./Tab_Files

# Set the directory
sample_dir="/mnt/gs21/scratch/cholicog/Rat/Alignment_Data_LiftOver/"

cp ${sample_dir}*.out ./Reports
cp ${sample_dir}*.err ./Reports
cp ${sample_dir}*.tab ./Tab_Files

