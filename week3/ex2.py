import pandas as pd

names = ["CHROM", "POS","ID","REF","ALT","QUAL","FILTER","INFO","FORMAT","A01_62","A01_39","A01_63","A01_35","A01_31","A01_27","A01_24","A01_23","A01_11","A01_09"]
V = pd.read_csv('./biallelic.vcf', sep='\t', comment='#', names=names)

# extract AF info and save
V['INFO'].str.split(';').str[3].str.replace('AF=', '').to_csv('./AF.txt', sep='\t', index=False)

samples = V.columns[V.columns.str.startswith('A0')].to_list()
