# Week 2 Assignment

## Problem 1 commands

`bowtie2 -p 4 -x ../genomes/sacCer3 -U /Users/cmdb/Data/BYxRM/fastq/A01_01.fq.gz > A01_01.sam`

`samtools sort -o A01_01.bam A01_01.sam`

`samtools index A01_01.bam`

`samtools idxstats A01_01.bam > A01_01.idxstats`

Based on the haplotype data, samples 1, 3, and 4 all have the same haplotype, whereas 2, 5, and 6 all have the same different haplotype. When looking at the IGV screenshot, 1, 3, and 4 all look similar whereas 2, 5, and 6 look similar.