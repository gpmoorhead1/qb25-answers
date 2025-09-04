import fasta
import sys
from codons import forward, reverse

dicts = {}
for i in range(1, len(sys.argv)):
    file = sys.argv[i]

    with open(file) as f:
        fa = fasta.FASTAReader(f)

        aas = {}
        for ident, sequence in fa:
            # print(ident)
            for i in range(0, len(sequence), 3):
                codon = sequence[i:i+3]
                # print(codon)
                aa = forward[codon]

                if aa in aas:
                    aas[aa] += 1
                else:
                    aas[aa] = 1


        dicts[file] = (dict(sorted(aas.items())))

with open('cyto-v-mem.tsv', 'w') as f:
    for aa in dicts[file]:
        f.write(f"{aa}")
        for d in dicts:
            f.write(f"\t{dicts[d][str(aa)]}")
        f.write('\n')
