#!/bin/bash

# Define input and output directories
input_dir="data/raw_reads"
output_dir="data/processed_reads"

# Create output directory if it doesn't exist
mkdir -p $output_dir

# Loop through FASTQ files in the input directory
for file in $input_dir/*.fastq.gz; do
    filename=$(basename $file)
    base="${filename%.*}"
    
    # Perform quality trimming and adapter removal
    trimmomatic PE -phred33 $input_dir/${base}_1.fastq.gz $input_dir/${base}_2.fastq.gz \
        $output_dir/${base}_1.trimmed.fastq.gz $output_dir/${base}_1.untrimmed.fastq.gz \
        $output_dir/${base}_2.trimmed.fastq.gz $output_dir/${base}_2.untrimmed.fastq.gz \
        LEADING:20 TRAILING:20 SLIDINGWINDOW:4:15 MINLEN:36
done
