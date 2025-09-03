import gzip

expression_fname = "/Users/cmdb/Data/GTEx/GTEx_Analysis_2017-06-05_v8_RNASeQCv1.1.9_gene_tpm.gct.gz"

fs = gzip.open(expression_fname)

_ = fs.readline()
_ = fs.readline()

header = fs.readline().decode().rstrip().split("\t")
gene = fs.readline().decode().rstrip().split("\t")

fs.close()

sample_expr = {}
for i in range(len(header)):
    sample_expr[header[i]] = gene[i]

metadata_fname = "/Users/cmdb/Data/GTEx/GTEx_Analysis_v8_Annotations_SampleAttributesDS.txt"
metadata = {}
with open(metadata_fname, 'r') as f:
    for line in f:
        split = line.split('\t')
        if split[0] == 'SAMPID':
            continue
        metadata[split[0]] = split[6]

for sample in metadata:
    if sample in sample_expr:
        print(sample, sample_expr[sample], metadata[sample]) 


print('First 3 tissues with nonzero expression')
counter = 0
for sample in metadata:
    if sample in sample_expr:
        if float(sample_expr[sample]) > 0:
            print(sample, sample_expr[sample], metadata[sample])
            counter += 1
    if counter == 3:
        break