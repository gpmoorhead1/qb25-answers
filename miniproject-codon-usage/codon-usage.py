import fasta
import sys

with open(sys.argv[1]) as f:
    fasta = fasta.FASTAReader(f)

    for ident, sequence in fasta:
        # print(ident)
        for i in range(0, len(sequence), 3):
            codon = sequence[i:i+3]
            # print(codon)