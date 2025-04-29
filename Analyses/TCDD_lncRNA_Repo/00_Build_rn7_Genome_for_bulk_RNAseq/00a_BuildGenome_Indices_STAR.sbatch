#!/bin/bash --login

####### Define resources ########
#https://wiki.hpcc.msu.edu/display/ITH/Job+Script+and+Job+Submission

#SBATCH --job-name=Ref_Genome
#SBATCH --output=Ref_Genome_Ratio.out
#SBATCH --error=Ref_Genome_Ratio.err

#Number of nodes needed:
#SBATCH --nodes=1
#
#Tasks per node:
#SBATCH --ntasks-per-node=1
#
#Processors per task:
#SBATCH --cpus-per-task=6
#
#Memory per node:
#SBATCH --mem=64G
#
#Wall time (e.g. "minutes", "hours:minutes:seconds", "days-hours", "days-hours:minutes"):
#SBATCH --time=4:00:00
#

########### Command lines ###########

module purge
module load STAR/2.7.11b-GCC-13.2.0

################
# Check if the directory exists
if [ ! -d "./rn7_Genome" ]; then
    echo "Directory ./rn7_Genome does not exist. Creating it..."
    mkdir ./rn7_Genome
else
    echo "Directory ./rn7_Genome already exists."
fi


################
# Navigate to the directory
cd ./rn7_Genome

# Check if the genome file already exists
if [ ! -f "rn7.fa.gz" ]; then
    echo "Downloading rat genome..."
    curl -O https://hgdownload.soe.ucsc.edu/goldenPath/rn7/bigZips/rn7.fa.gz
else
    echo "Rat genome file already exists."
fi

################
# Unzip the genome file if the unzipped file does not exist
if [ ! -f "rn7.fa" ]; then
    echo "Unzipping the genome file..."
    gunzip rn7.fa.gz
else
    echo "Unzipped genome file already exists."
fi

################
echo building Genome ...


# Define variables
GTF_FILE="../../00_Karri_et_al_GTF/Karri_Annotations_Restructured_rn7_for_Gene_Expression.gtf"
FASTA_FILE="./rn7.fa"

STAR --runThreadN 6 \
--runMode genomeGenerate \
--genomeDir . \
--genomeFastaFiles ${FASTA_FILE} \
--sjdbGTFfile ${GTF_FILE} \
--sjdbOverhang 149 \
--genomeSAindexNbases 12 \
--limitGenomeGenerateRAM 60000000000

echo done!

