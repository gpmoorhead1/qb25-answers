import fasta
import sys
from codons import forward, reverse

with open(sys.argv[1]) as f:
    fasta = fasta.FASTAReader(f)

    aas = {}
    for ident, sequence in fasta:
        # print(ident)
        for i in range(0, len(sequence), 3):
            codon = sequence[i:i+3]
            # print(codon)
            aa = forward[codon]

            if aa in aas:
                aas[aa] += 1
            else:
                aas[aa] = 1


print(aas)