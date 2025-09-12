# Problem 1

bedtools makewindows -g hg19-main.chrom.sizes -w 1000000 > hg19-1mb.bed

bedtools intersect -a hg19-1mb.bed -b hg19-kc.bed -c > hg19-kc-count.bed