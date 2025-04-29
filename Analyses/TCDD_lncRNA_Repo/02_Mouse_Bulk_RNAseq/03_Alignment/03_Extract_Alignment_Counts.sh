#!/bin/bash

# Define the output file
output_file="./Unique_Alignment_Counts.txt"

# Initialize an array to store the values
unique_counts=()

# Write the header to the output file
echo -e "Sample\tUniquely_Mapped_Reads" > "$output_file"

# Loop through all *_Log.final.out files in the ./Reports directory
for file in ./Reports/*_Log.final.out; do
    # Extract the sample name (e.g., L01 from L01_Log.final.out)
    sample=$(basename "$file" | cut -d'_' -f1)
    
    # Extract the 'Uniquely mapped reads number' value
    unique_reads=$(grep "Uniquely mapped reads number" "$file" | awk '{print $NF}')
    
    # Append the sample and value to the output file
    echo -e "$sample\t$unique_reads" >> "$output_file"
    
    # Store the value in the array for calculation
    unique_counts+=("$unique_reads")
done

# Calculate mean and median using awk and format the numbers
mean=$(echo "${unique_counts[@]}" | tr ' ' '\n' | awk '{sum+=$1} END {printf "%.0f", sum/NR}')
median=$(echo "${unique_counts[@]}" | tr ' ' '\n' | sort -n | awk '{
    count[NR] = $1;
} END {
    if (NR % 2 == 1) {
        printf "%.0f", count[(NR + 1) / 2];
    } else {
        printf "%.0f", (count[NR / 2] + count[(NR / 2) + 1]) / 2;
    }
}')

# Append mean and median to the output file
echo -e "\nMean\t$mean" >> "$output_file"
echo -e "Median\t$median" >> "$output_file"

# Print a success message
echo "Unique alignment counts, mean, and median have been saved to $output_file."
