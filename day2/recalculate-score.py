#!/usr/bin/env python3

file = '/Users/cmdb/git/qbb2025/unix-python-scripts/ce11_genes.bed'

with open(file, 'r') as f:
    for line in f:
        split = line.split('\t')

        chrom = split[0]
        start = int(split[1])
        end = int(split[2])
        samp = split[3]
        score = int(split[4])
        strand = split[5]

        factor = None
        if strand=='-':
            factor = 1
        else: factor = -1

        new = score * (end - start) * factor

        print(chrom, start, end, samp, score, new, strand, sep='\t')