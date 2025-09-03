gtf_file = '/Users/cmdb/Desktop/day2/gencode.v46.basic.annotation.gtf'

file = open(gtf_file, 'r')

for line in file:
    if line.startswith('#'):
        continue

    items = line.split('\t')
    if items[2] != 'gene':
        continue
    
    chr = items[0]
    start = int(items[3]) - 1
    end = items[4]

    gene_name = None
    attribute = items[8].replace(' ', '').split(';')
    for attr in attribute:
        if "gene_name" in attr:
            gene_name = attr.replace('gene_name', '').strip('"')

    print(chr, start, end, gene_name)

file.close()