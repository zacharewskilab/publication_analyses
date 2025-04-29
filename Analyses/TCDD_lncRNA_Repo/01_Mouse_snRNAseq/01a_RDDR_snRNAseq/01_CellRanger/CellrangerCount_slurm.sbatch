#!/bin/bash --login

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=12 
#SBATCH --cpus-per-task=10
#SBATCH --mem=32G
#SBATCH --time=36:00:00
#SBATCH --account=toxicogenomics


##############################

date 
date 
date

export PATH=/mnt/research/zacharewski_lab/Scripts/CellRangerInstallations/cellranger-8.0.1:$PATH

### change to the directory where you want data output to be

cellranger count --id=${sampleid} \
   --transcriptome=/mnt/ufs18/home-183/cholicog/Jupyter_Notebooks/Working_lncRNA/00_Build_mm39_Genome_for_snRNAseq/mm39_genome \
   --fastqs=${in_path} \
   --expect-cells=6000 \
   --localcores=10 \
   --jobmode=slurm \
   --maxjobs=5 \
   --mempercore=32000 \
   --create-bam true

scontrol show job $SLURM_JOB_ID

echo 'Done'

date 
date 
date
