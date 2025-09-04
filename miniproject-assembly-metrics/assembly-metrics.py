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

print(len(contigs), mean(lengths), sum(lengths))