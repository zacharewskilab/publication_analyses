#!/bin/bash

# Set the directory
sample_dir="/mnt/gs21/scratch/cholicog/Rat/Concatenated/"
cd $sample_dir

mkdir Pre-Trim_FastQC
mkdir Trim_Files
mkdir Post-Trim_FastQC
mkdir QC_and_Trim_Reports

# Loop through each .fastq.gz file and submit a job
for f in *.fastq.gz
do
  sample_name=$(basename ${f%.fastq.gz})
  
  # Create a SLURM job script for this sample
  echo "#!/bin/bash --login
#SBATCH --job-name=Trim_${sample_name}
#SBATCH --output=QC_and_Trim_${sample_name}.out
#SBATCH --error=QC_and_Trim_${sample_name}.err
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=16G
#SBATCH --time=04:00:00


####################################
### First QC (Pre-Trim)
####################################
# Load the necessary modules

module purge
module load FastQC/0.12.1-Java-11
module list

echo "Running initial QC on files in ${sample_dir}"

echo "Running FastQC on $f"
fastqc $f
echo "First QC complete"

mv *fastqc* ./Pre-Trim_FastQC

####################################
### Trim
####################################
module purge
module load Trimmomatic/0.39-Java-17
module list

echo "Trimming adapters from $f"

# Trimming adapters from $f
java -jar \$EBROOTTRIMMOMATIC/trimmomatic-0.39.jar \
SE -threads \${SLURM_CPUS_ON_NODE} -trimlog ${sample_name}_trim.log \
$f trimmed.${sample_name}.fastq.gz \
ILLUMINACLIP:/mnt/research/zacharewski_lab/Scripts/RNAseq_STAR/NovogeneAdapters.fa:2:30:10 \
LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36

mv *trim* ./Trim_Files

####################################
### Second QC (Post-Trim)
####################################
module purge
module load FastQC/0.12.1-Java-11 
module list

echo "Running FastQC on trimmed.${f%.fastq.gz}.fastq.gz"

# Run FastQC on the trimmed file
fastqc trimmed.${sample_name}.fastq.gz

mv *fastqc* ./Post-Trim_FastQC
mv QC_and_Trim* ./QC_and_Trim_Reports

echo \"Finished trimming and QC for ${sample_name}\"" > trim_${sample_name}.slurm
  
  # Submit the job
  sbatch trim_${sample_name}.slurm

done
