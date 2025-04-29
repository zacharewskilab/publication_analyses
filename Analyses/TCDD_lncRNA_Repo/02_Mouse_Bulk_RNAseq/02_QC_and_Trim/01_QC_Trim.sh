#!/bin/bash

# Set the directory
sample_dir="/mnt/gs21/scratch/cholicog/Mouse/RAW_FASTQ/Consolidated"
cd $sample_dir

mkdir Pre-Trim_FastQC
mkdir Trim_Files
mkdir Post-Trim_FastQC
mkdir QC_and_Trim_Reports

# Loop through each paired-end sample
for f1 in *_1.fq.gz
do
  # Derive the base sample name
  sample_name=$(basename ${f1%_1.fq.gz})
  f2="${sample_name}_2.fq.gz"
  
  # Create a SLURM job script for this sample
  echo "#!/bin/bash --login
#SBATCH --job-name=${sample_name}_Trim
#SBATCH --output=QC_and_Trim_${sample_name}.out
#SBATCH --error=QC_and_Trim_${sample_name}.err
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=12
#SBATCH --mem=16G
#SBATCH --time=04:00:00

# Load the necessary modules
module purge
module load FastQC/0.12.1-Java-11
module list

echo "Running initial QC on files in ${sample_dir}"

# Run FastQC on both paired-end files
echo "Running FastQC on $f1 and $f2"
fastqc $f1
fastqc $f2
echo "First QC complete"

mv *fastqc* ./Pre-Trim_FastQC

module purge
module load Trimmomatic/0.39-Java-17

echo "Trimming adapters from $f1 and $f2"

# Trimming adapters from paired-end files
java -jar \$EBROOTTRIMMOMATIC/trimmomatic-0.39.jar \
PE -threads \${SLURM_CPUS_ON_NODE} -trimlog ${sample_name}_trim.log \
$f1 $f2 \
trimmed.${sample_name}_1.fq.gz un.trimmed.${sample_name}_1.fq.gz \
trimmed.${sample_name}_2.fq.gz un.trimmed.${sample_name}_2.fq.gz \
ILLUMINACLIP:/mnt/research/zacharewski_lab/Scripts/RNAseq_STAR/NovogeneAdapters.fa:2:30:10 \
LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36

mv *trim* ./Trim_Files

# Load the necessary modules
module purge
module load FastQC/0.12.1-Java-11
module list

echo "Running FastQC on trimmed files"

# Run FastQC on trimmed files
fastqc ./Trim_Files/trimmed.${sample_name}_1.fq.gz
fastqc ./Trim_Files/trimmed.${sample_name}_2.fq.gz

mv *fastqc* ./Post-Trim_FastQC

mv QC_and_Trim* ./QC_and_Trim_Reports

echo \"Finished trimming and QC for ${sample_name}\"" > trim_${sample_name}.slurm
  
  # Submit the job
  sbatch trim_${sample_name}.slurm

done
