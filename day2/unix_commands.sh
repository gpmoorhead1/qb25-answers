#!/bin/bash

##### Problem 1
# /Users/cmdb/git/qbb2025/unix-python-scripts/ce11_genes.bed

# a
wc -l /Users/cmdb/git/qbb2025/unix-python-scripts/ce11_genes.bed
# 53935 /Users/cmdb/git/qbb2025/unix-python-scripts/ce11_genes.bed

# b
cut -f 1 /Users/cmdb/git/qbb2025/unix-python-scripts/ce11_genes.bed | uniq -c
# 5460 chrI
#   12 chrM
# 9057 chrV
# 6840 chrX
# 6299 chrII
# 21418 chrIV
# 4849 chrIII

# c
cut -f 6 /Users/cmdb/git/qbb2025/unix-python-scripts/ce11_genes.bed | sort | uniq -c
# 26626 -
# 27309 +



###### Problem 3
#/Users/cmdb/Data/GTEx/GTEx_Analysis_v8_Annotations_SampleAttributesDS.txt

# a
cut -f 7 /Users/cmdb/Data/GTEx/GTEx_Analysis_v8_Annotations_SampleAttributesDS.txt | sort | uniq -c | sort | tail -n 3
#  867 Lung
# 1132 Muscle - Skeletal
# 3288 Whole Blood

# b
grep "RNA" /Users/cmdb/Data/GTEx/GTEx_Analysis_v8_Annotations_SampleAttributesDS.txt | wc -l
# 20017

# c
grep -v "RNA" /Users/cmdb/Data/GTEx/GTEx_Analysis_v8_Annotations_SampleAttributesDS.txt | wc -l
# 2935



###### Problem 5
# ~/Data/References/hg38/gencode.v46.basic.annotation.gtf

# a
grep -v "#" gencode.v46.basic.annotation.gtf | cut -f 3 | sort | uniq -c
# 664771 CDS
# 865650 exon
# 63086 gene
#  107 Selenocysteine
# 64970 start_codon
# 64806 stop_codon
# 118625 transcript
# 182871 UTR

# b
grep lncRNA gencode.v46.basic.annotation.gtf | cut -f 3 | sort | uniq -c
# 107305 exon
# 19258 gene
# 30098 transcript

