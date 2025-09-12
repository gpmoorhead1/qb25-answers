# how many genes are in hg19?
wc -l ../exercise1/hg19-kc.bed
# 80270 transcripts

# how many genes are in hg19 but not in hg16
bedtools intersect -v -a ../exercise1/hg19-kc.bed -b hg16-kc.bed | wc -l
# 42717 transcripts

# There are more areas of the genome mapped on in hg19, which means that more genes were discovered since hg16.

# how many genes are in hg16?
wc -l hg16-kc.bed
# 21365 transcripts

# how many genes are in hg16 but not in hg19?
bedtools intersect -v -b ../exercise1/hg19-kc.bed -a hg16-kc.bed | wc -l
# 3460 transcripts

# since more of the genome has been mapped out, some genes that were in specific locations in hg16 have moved locations in hg19