#!/bin/bash --login


#SBATCH --job-name=Ref_Genome
#SBATCH --output=Ref_Genome.out
#SBATCH --error=Ref_Genome.err
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=10
#SBATCH --cpus-per-task=10
#SBATCH --mem=100G
#SBATCH --time=2:00:00
#SBATCH --account=toxicogenomics


#export PATH=/mnt/research/zacharewski_lab/Scripts/CellRangerInstallations/cellranger-4.0.0:$PATH

date
date
date

module load CellRanger/8.0.1


cellranger mkref \
    --genome=mm39_genome \
    --fasta=mm39.fa \
    --genes=../00_Karri_et_al_GTF/Karri_Annotations_Restructured_mm39.gtf \
    --memgb=100 \
    --nthreads=10 \

scontrol show job $SLURM_JOB_ID

rm mm39.fa

date
date
date

echo 'Done'
