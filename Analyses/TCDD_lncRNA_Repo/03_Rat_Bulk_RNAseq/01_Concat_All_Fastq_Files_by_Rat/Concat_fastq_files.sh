cd /mnt/gs21/scratch/cholicog/

mkdir ./Rat/Concatenated


for L in 13 15 16 20 22 24 28 29 32 37 38 40 45 46 48 52 55 56 60 61 62 70 71 72
do
    # Find files that match the pattern (if they exist)
    FILES=$(ls ./Rat/20140908_mRNASeq/L${L}_*_R1_001.fastq.gz \
               ./Rat/20140909_mRNASeq/L${L}_*_R1_001.fastq.gz \
               ./Rat/20140925_mRNASeq/L${L}_*_R1_001.fastq.gz 2>/dev/null)

    # Check if any files were found
    if [[ -n "$FILES" ]]; then
        cat $FILES > ./Rat/Concatenated/L${L}_R1_001_combined.fastq.gz
        echo "Concatenated files for L${L}"
    else
        echo "No files found for L${L}, skipping..."
    fi
done
