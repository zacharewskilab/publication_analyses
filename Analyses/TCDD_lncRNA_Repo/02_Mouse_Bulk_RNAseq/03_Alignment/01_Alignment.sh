#!/bin/bash

module purge

# Set the directories
sample_dir="/mnt/gs21/scratch/cholicog/Mouse/RAW_FASTQ/Consolidated/Trim_Files"
output_dir="/mnt/gs21/scratch/cholicog/Mouse/Alignment_Data/"

echo "Submitting SLURM jobs for all fastq.gz files in ${sample_dir}"

# Ensure the output directory exists
mkdir -p ${output_dir}

# Loop through forward read files (_1.fq.gz) and find the corresponding reverse read (_2.fq.gz)
for f1 in ${sample_dir}/trimmed*_1.fq.gz
do
  # Derive the reverse read file name by replacing "_1" with "_2"
  f2="${f1/_1.fq.gz/_2.fq.gz}"
  
  # Extract the sample name (remove "trimmed." and "_1.fq.gz")
  sample=$(basename ${f1} | sed 's/^trimmed\.//' | sed 's/P161_//' | sed 's/_1\.fq\.gz$//')
  
  echo "Submitting job for ${sample} (files: ${f1}, ${f2})"
  
  # Submit the SLURM job dynamically
  sbatch <<EOF
#!/bin/bash --login
#SBATCH --job-name=${sample}_STAR
#SBATCH --output=${output_dir}/${sample}_STAR_Alignment.out
#SBATCH --error=${output_dir}/${sample}_STAR_Alignment.err
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --time=4:00:00
#SBATCH --cpus-per-task=8
#SBATCH --mem=32G

module purge
module load STAR/2.7.11b-GCC-13.2.0

STAR --genomeDir /mnt/ufs18/home-183/cholicog/Jupyter_Notebooks/Working_lncRNA/00_Build_mm39_Genome_for_bulk_RNAseq/mm39_Genome \
  --readFilesIn ${f1} ${f2} \
  --readFilesCommand gunzip -c \
  --outSAMtype BAM SortedByCoordinate \
  --quantMode GeneCounts \
  --runThreadN 8 \
  --outFileNamePrefix ${output_dir}/${sample}_

echo "Finished aligning ${sample}"
EOF

done

echo "All SLURM jobs have been submitted"
