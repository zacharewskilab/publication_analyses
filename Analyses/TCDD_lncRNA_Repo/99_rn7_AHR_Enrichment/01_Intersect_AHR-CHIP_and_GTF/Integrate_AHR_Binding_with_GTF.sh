#!/bin/bash

module load BEDTools/2.31.0-GCC-12.3.0

GTF_File='../../00_Karri_et_al_GTF/Karri_Annotations_Restructured_rn7.gtf'
AHR_File='./RAW_Data/AHR_Enrichment_Female_2hr_rn7.bed'

##############################
### Process GTF File
##############################
sed 's/ //g' ${GTF_File} > GTF_Processed4.gtf 

awk '{
  if ($7 == "+") {
    orig = $4;
    $4 = $4 - 10000;
    if ($4 < 0) $4 = 1;
    print orig "\t" $1 "\t" $4 "\t" $5 "\t" $7 "\t" $9;
  } else if ($7 == "-") {
    orig = $5;
    $5 = $5 + 10000;
    if ($5 < 0) $5 = 1;
    print orig "\t" $1 "\t" $4 "\t" $5 "\t" $7 "\t" $9;
  }
}' GTF_Processed4.gtf > GTF_Processed5.gtf 

sort -k2,2 -k3,3n GTF_Processed5.gtf | awk '{print $2 "\t" $3 "\t" $4 "\t" $5 "\t" $1 "\t" $6 }' > GTF_Processed6.gtf 



##############################
### Bedtools Intersection Analysis
##############################
#bedtools intersect -a ChIP_Processed4.bed -b GTF_Processed6.gtf -wa -wb -loj > Overlapping_Regions.bed
bedtools intersect -a "${AHR_File}" -b GTF_Processed6.gtf -wa -wb -loj > Overlapping_Regions.bed

# Add headers to results
echo -e "Chromosome\tAHR_Bound_Start\tAHR_Bound_End\tAHR_Site_Unique_ID\tAHR_Binding_FC\tAHR_Binding_FDR\tGTF_Chromosome\tGene_Start\tGene_End\tGene_Strand\tGene_ORIG_Start\tMetadata" > temp_file.txt
cat Overlapping_Regions.bed >> temp_file.txt
mv temp_file.txt rn7_AHR_Binding_Regions.bed



rm GTF_Processed4.gtf 
rm GTF_Processed5.gtf 
rm GTF_Processed6.gtf
rm Overlapping_Regions.bed
