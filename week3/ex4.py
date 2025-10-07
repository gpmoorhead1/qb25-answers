#!/usr/bin/env python3

import pandas as pd

# load vcf
names = ["CHROM", "POS","ID","REF","ALT","QUAL","FILTER","INFO","FORMAT","A01_62","A01_39","A01_63","A01_35","A01_31","A01_27","A01_24","A01_23","A01_11","A01_09"]
V = pd.read_csv('./biallelic.vcf', sep='\t', comment='#', names=names)

# grab samples
samples = V.columns[V.columns.str.startswith('A0')].to_list()

# melt dataframe
melt = V.melt(id_vars=['CHROM', 'POS'], value_vars=samples, var_name='sample', value_name='genotype')

# extract genotype from info column
melt['genotype'] = melt['genotype'].str.split(':').str[0]

# drop non 0/1 columns
melt = melt[melt['genotype'].isin(['0', '1'])]

het_min = 2
counts = {}

for sample in samples:
    genotypes = melt[melt['sample']==sample]['genotype'].to_list()
    counts[sample] = 0

    for i in range(1, len(genotypes)):
        if genotypes[i] != genotypes[i-1]:
            if genotypes[i-1] in genotypes[i:]:
                if genotypes[i:].index(genotypes[i-1]) > het_min:
                    counts[sample] += 1
            elif len(genotypes[i:]) > het_min:
                counts[sample] += 1


pd.DataFrame.from_dict(counts, orient='index').reset_index().rename(columns={'index':'sample', 0:'Number_Crossovers'}).to_csv('crossovers.txt', sep='\t', index=False)
