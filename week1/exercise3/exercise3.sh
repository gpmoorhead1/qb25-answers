# test overlap between active and repressed in a given condition
bedtools intersect -a nhlf-active.bed -b nhlf-repressed.bed

# regions active in NHEK and NHLF
bedtools intersect -a nhek-active.bed -b nhlf-active.bed
# outputs 12174 features

# regions that are active in NHEK but not active in NHLF
bedtools intersect -v -a nhek-active.bed -b nhlf-active.bed
# outputs 2405 features

# this doesn't add up to the size of nhek-active.bed (14013 features). the first command could be updated to 
# bedtools intersect -u -a nhek-active.bed -b nhlf-active.bed
# to report one feature per overlap

bedtools intersect -f 1 -a nhek-active.bed -b nhlf-active.bed
# increases the minimum amount of overlap required in NHEK bed
# in the genome browser, the NHEK active promoter site is smaller than the NHLF active promoter site

bedtools intersect -F 1 -a nhek-active.bed -b nhlf-active.bed
# increases the minimum amount of overlap required in NHLF bed
# in the genome browser, the NHEK active promoter site is larger than the NHLF active promoter site

bedtools intersect -f 1 -F 1 -a nhek-active.bed -b nhlf-active.bed
# increases the minimum amount of overlap in both the NHEK and NHLF bed
# in the genome browser, the size of the NHEK and NHLF active promoter sites seem to be the same size


# active in NHEK, active in NHLF
bedtools intersect -a nhek-active.bed -b nhlf-active.bed
# this region is encompassed entirely by an active promoter region in NHLF, NHEK, HSMM, HepG2, H1-hESC and GM12878.
# in K562, this locus is a active promoter surrounded by 2 strong enhancer regions.
# in HUVEC and HMEC, this locus starts with a strong enhancer followed by an active promoter region

# active in NHEK, repressed in NHLF
bedtools intersect -a nhek-active.bed -b nhlf-repressed.bed
# this region is entirely an active promoter in NHEK, HMEC, H1-hESC, and GM12878
# this region is entirely repressed in NHLF and HSMM
# in K562, this region is an insulator area followed by a weak enhancer area
# in HUVEC, this region is a repressed area followed by a poised promoter area
# in HepG2, this region is entirely a strong enhancer

# repressed in NHEK, repressed in NHLF
bedtools intersect -a nhek-repressed.bed -b nhlf-repressed.bed
# in NHLF, NHEK, HSMM, HMEC, and H1-hESC, this region is entirely repressed
# in K562, HUYVEC, HepG2, and GM12878, this region is a heterochromatin region