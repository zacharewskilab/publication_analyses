#!/bin/bash

AHR_File='./RAW_Data/AHR_Enrichment_Male_2hr.txt'

tail -n +2 "$AHR_File" | sort -k2,2 -k3,3n | awk '!seen[$2, $3, $4]++ {print $2 "\t" $3 "\t" $4 "\t" $1}' > temp_AHR_mm10.bed
awk '$6 <= 0.05' temp_AHR_mm10.bed > temp_AHR_mm10_filtered.bed

# Download the UCSC LiftOver executable
wget -O liftOver https://hgdownload.soe.ucsc.edu/admin/exe/linux.x86_64/liftOver

# Make the file executable
chmod +x liftOver

# Download mm10 to rn6 liftover chain
wget -O mm10ToMm39.over.chain.gz https://hgdownload.soe.ucsc.edu/goldenPath/mm10/liftOver/mm10ToMm39.over.chain.gz

./liftOver -minMatch=0.7 temp_AHR_mm10_filtered.bed mm10ToMm39.over.chain.gz ./RAW_Data/AHR_Enrichment_Male_2hr_mm39.bed ./RAW_Data/unmapped_AHR_Enrichment_Male_2hr_mm39.bed


rm -r temp_AHR_mm10.bed
rm -r temp_AHR_mm10_filtered.bed
rm -r liftOver
rm -r mm10ToMm39.over.chain.gz



