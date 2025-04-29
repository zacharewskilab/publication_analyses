#!/bin/bash

module purge

# Set the directories
sample_dir="/mnt/gs21/scratch/cholicog/Rat/Concatenated/Trim_Files/"
output_dir="/mnt/gs21/scratch/cholicog/Rat/Alignment_Data_LiftOver/"

echo "Submitting SLURM jobs for all trimmed.fastq.gz files in ${sample_dir}"

# Ensure the output directory exists
mkdir -p ${output_dir}

# Loop through each trimmed.fastq.gz file and submit a separate SLURM job for each alignment
for f in ${sample_dir}/trimmed.*.fastq.gz
do
  # Extract sample name
  sample=$(basename ${f%.fastq.gz})
  echo "Submitting job for ${sample}"
  
  # Submit the SLURM job dynamically
  sbatch <<EOF
#!/bin/bash --login
#SBATCH --job-name=STAR_${sample}
#SBATCH --output=${output_dir}/${sample}_STAR_Alignment.out
#SBATCH --error=${output_dir}/${sample}_STAR_Alignment.err
#SBATCH --time=4:00:00
#SBATCH --cpus-per-task=8
#SBATCH --mem=32G

module purge
module load STAR/2.7.11b-GCC-13.2.0

STAR --genomeDir /mnt/ufs18/home-183/cholicog/Jupyter_Notebooks/Working_lncRNA/00_Build_rn7_Genome_for_bulk_RNAseq/rn7_Genome \
  --readFilesIn ${f} \
  --readFilesCommand gunzip -c \
  --outSAMtype BAM SortedByCoordinate \
  --quantMode GeneCounts \
  --runThreadN 8 \
  --outFileNamePrefix ${output_dir}/${sample}_

echo "Finished aligning ${sample}"
EOF

done

echo "All SLURM jobs have been submitted"
