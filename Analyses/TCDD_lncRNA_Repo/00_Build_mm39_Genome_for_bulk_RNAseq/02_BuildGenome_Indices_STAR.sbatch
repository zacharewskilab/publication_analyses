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
#SBATCH --cpus-per-task=9
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
if [ ! -d "./mm39_Genome" ]; then
    echo "Directory ./mm39_Genome does not exist. Creating it..."
    mkdir ./mm39_Genome
else
    echo "Directory ./mm39_Genome already exists."
fi


################
# Navigate to the directory
mv mm39.fa ./mm39_Genome

cd ./mm39_Genome

################
echo building Genome ...


# Define variables
GTF_FILE="../../00_Karri_et_al_GTF/Karri_Annotations_Restructured_mm39.gtf"
FASTA_FILE="./mm39.fa"

STAR --runThreadN 9 \
--runMode genomeGenerate \
--genomeDir . \
--genomeFastaFiles ${FASTA_FILE} \
--sjdbGTFfile ${GTF_FILE} \
--sjdbOverhang 149 \
--genomeSAindexNbases 12 \
--limitGenomeGenerateRAM 60000000000

rm  ./mm39.fa

echo done!

