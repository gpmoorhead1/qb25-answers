#!/usr/bin/env python3

import fasta
import sys
from statistics import mean

with open(sys.argv[1]) as f:
    fasta = fasta.FASTAReader(f)

    contigs = []
    lengths = []
    counter = 0
    for ident, sequence in fasta:
        contigs.append(ident)
        lengths.append(len(sequence))

print(f"Number of contigs: {len(contigs)}", f"Mean length of Contig: {mean(lengths)}", f"Sum of contig lengths: {sum(lengths)}")

lengths.sort(reverse=True)
total_length = sum(lengths)

current_sum = lengths[0]
for i in range(1, len(lengths)):
    current_sum += lengths[i]
    if current_sum > total_length / 2:
        break

print('sequence length of the shortest contig at 50% of the total assembly length: ', lengths[i])
