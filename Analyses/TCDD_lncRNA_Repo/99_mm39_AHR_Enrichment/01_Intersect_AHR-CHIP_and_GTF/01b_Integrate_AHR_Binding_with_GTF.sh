#!/bin/bash

module load BEDTools/2.31.0-GCC-12.3.0
module list

GTF_File='../../00_Karri_et_al_GTF/Karri_Annotations_Restructured_mm39.gtf'
AHR_File='./RAW_Data/AHR_Enrichment_Male_2hr_mm39.bed'

##############################
### Process GTF File
##############################
awk '!/random/' "$GTF_File" > GTF_Processed1.gtf
awk '!/^ERCC/' GTF_Processed1.gtf > GTF_Processed2.gtf
awk '!/^Un/' GTF_Processed2.gtf > GTF_Processed3.gtf 
sed 's/ //g' GTF_Processed3.gtf > GTF_Processed4.gtf 

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
### Process AHR-ChIP File
##############################
#grep -v "Active" $AHR_File | sort -k2,2 -k3,3n > ChIP_Processed1.txt
#cut -f 1,2,3,4,9 ChIP_Processed1.txt| awk '{print $2 "\t" $3 "\t" $4 "\t" $5 "\t" $1}' > ChIP_Processed2.bed
#tr -d '\r' < ChIP_Processed2.bed> ChIP_Processed3.bed

##############################
### Bedtools Intersection Analysis
##############################
bedtools intersect -a "$AHR_File" -b GTF_Processed6.gtf -wa -wb -loj > Overlapping_Regions.bed

# Add headers to results
echo -e "Chromosome\tAHR_Bound_Start\tAHR_Bound_End\tAHR_Site_Unique_ID\tGTF_Chromosome\tGene_Start\tGene_End\tGene_Strand\tGene_ORIG_Start\tMetadata" > temp_file.txt
cat Overlapping_Regions.bed >> temp_file.txt
mv temp_file.txt ./RAW_Data/mm10_AHR_Binding_Regions_temp.bed


rm GTF_Processed1.gtf
rm GTF_Processed2.gtf
rm GTF_Processed3.gtf 
rm GTF_Processed4.gtf 
rm GTF_Processed5.gtf 
rm GTF_Processed6.gtf
rm Overlapping_Regions.bed