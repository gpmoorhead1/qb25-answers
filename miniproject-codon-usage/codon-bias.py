import fasta
import sys
from codons import forward, reverse

counts = {}
with open(sys.argv[1], 'r') as f:
    fa = fasta.FASTAReader(f)

    for ident, sequence in fa:
        for i in range(0, len(sequence), 3):
            codon = sequence[i:i+3]

            if codon in counts:
                counts[codon] += 1
            else:
                counts[codon] = 1

aa = sys.argv[2]
aa_codons = reverse[aa]

count=0
for codon in aa_codons:
    if codon in counts:
        count += counts[codon]

with open(f'bias-{aa}.tsv', 'w') as f:
    f.write(f"{aa}\t{count}")