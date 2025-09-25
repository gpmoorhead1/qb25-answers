#!/usr/bin/env python3

import sys

file = sys.argv[1]

counts = {}
mismatches = {}

# counter = 1
with open(file, 'r') as f:
    for line in f:
        if line.startswith('@'):
            continue
        split = line.split('\t')
        chrom = split[2]

        if chrom in counts:
            counts[chrom] += 1
        else: counts[chrom] = 1

        key = None
        for s in split:
            if s.startswith('NM:i'):
                key = int(s.replace('NM:i:', ''))
        if key is not None:
            if key in mismatches:
                mismatches[key] += 1
            else: mismatches[key] = 1

        # counter += 1
        # if counter == 5:
        #     break

print('Chromosome Counts: ')
print(counts, 2*'\n')

print('Sorted Mismatches: ')
sorted_keys = sorted(mismatches.items())
sorted_mismatches = dict(sorted_keys)
print(sorted_mismatches)