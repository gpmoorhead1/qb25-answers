#!/bin/bash

for sample in A01_01 A01_02 A01_03 A01_04 A01_05 A01_06
do
    echo "***" $sample
    bowtie2 -p 4 -x ./genomes/sacCer3 -U /Users/cmdb/Data/BYxRM/fastq/$sample.fq.gz > ./variants/$sample.sam
    samtools sort -o ./variants/$sample.bam ./variants/$sample.sam
    samtools index -o ./variants/$sample.bam.bai ./variants/$sample.bam
done