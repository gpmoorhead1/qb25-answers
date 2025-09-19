# which gene has the most SNPs
bedtools intersect -a ../exercise1/hg19-kc.bed -b snps-chr1.bed -c | sort -k 5 -r -n | head -n 1
# SMYD3

# ENST00000490107.6_7; SMYD3; chr1:245912648-246670581; 757933 bp in length; 12 exons
# SMYD3 is a long gene, therefore it would make sense that this has a lot of SNPs

# sort subset of snps
bedtools sample -n 20 -seed 42 -i snps-chr1.bed | bedtools sort > snps-chr1_sorted.bed

# sort hg19-kc.bed
bedtools sort -i ../exercise1/hg19-kc.bed > hg19-kc_sorted.bed

# how many SNPs are inside of a gene?
bedtools closest -d -a snps-chr1_sorted.bed -b hg19-kc_sorted.bed | cut -f 11 | grep -w '0$' | wc -l
# answer: 18

# what is the range of distances for the ones outside a gene?
bedtools closest -d -a snps-chr1_sorted.bed -b hg19-kc_sorted.bed | cut -f 11 | grep -vw '0$'
# it ranges from 1664 to 22944