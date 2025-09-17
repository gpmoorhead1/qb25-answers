# which gene has the most SNPs
bedtools intersect -a ../exercise1/hg19-kc.bed -b snps-chr1.bed -c | sort -k 5 -r | head -n 1
# chr1    23037331        23247993        ENST00000374630.8_7     995

# ENST00000374630.8_7; EPHB2; chr1:23,037,332-23,247,993; 210,662bp in length; 16 exons
# EPHB2 is a long gene, therefore it would make sense that this has a lot of SNPs

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