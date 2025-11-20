#!/usr/bin/env python3

import sys
import numpy as np
from fasta import readFASTA


#====================#
# Read in parameters #
#====================#
print('Loading parameters...')
# The scoring matrix is assumed to be named "sigma_file" and the 
# output filename is assumed to be named "out_file" in later code
fasta_file = sys.argv[1]
sigma_file = sys.argv[2]
gap_penalty = int(sys.argv[3])
out_file = sys.argv[4]

# Read the scoring matrix into a dictionary
fs = open(sigma_file)
sigma = {}
alphabet = fs.readline().strip().split()
for line in fs:
	line = line.rstrip().split()
	for i in range(1, len(line)):
		sigma[(alphabet[i - 1], line[0])] = float(line[i])
fs.close()

# Read in the actual sequences using readFASTA
with open(fasta_file, 'r') as f:
    fasta = readFASTA(f)

sequence1 = fasta[0][1]
sequence2 = fasta[1][1]

#=====================#
# Initialize F matrix #
#=====================#
print('Initializing matrices...')
F_matrix = np.zeros((len(sequence1)+1, len(sequence2)+1), dtype=int)

for i, j in zip(range(len(sequence1)+1), range(len(sequence2)+1)):
    F_matrix[i,0] = i*gap_penalty
    F_matrix[0,j] = j*gap_penalty

#=============================#
# Initialize Traceback Matrix #
#=============================#
Trace = np.zeros((len(sequence1)+1, len(sequence2)+1), dtype='U')
Trace[0] = np.array(['h' for q in range(len(sequence2)+1)])
Trace[:, 0] = np.array(['v' for q in range(len(sequence1)+1)])
Trace[0, 0] = '-'

#===================#
# Populate Matrices #
#===================#
print('Populating Matrices...')
for i in range(len(sequence1)+1):
	F_matrix[i,0] = i*gap_penalty

for j in range(len(sequence2)+1):
	F_matrix[0,j] = j*gap_penalty

for i in range(1, len(sequence1)+1):
    for j in range(1, len(sequence2)+1):
        
        d = F_matrix[i-1, j-1] + sigma[(sequence1[i-1], sequence2[j-1])]
        h = F_matrix[i, j-1] + gap_penalty
        v = F_matrix[i-1, j] + gap_penalty
        
        max_score = max(d,h,v)
        F_matrix[i,j] = max_score

        if d == max_score:
            Trace[i, j] = 'd'
        elif h == max_score:
            Trace[i, j] = 'h'
        else:
            Trace[i, j] = 'v'

#========================================#
# Follow traceback to generate alignment #
#========================================#
print('Performing traceback...')
# The aligned sequences are assumed to be strings named sequence1_aligment
# and sequence2_alignment in later code

i, j = len(sequence1), len(sequence2)
sequence1_alignment, sequence2_alignment = '', ''

while i + j > 0:
    trace = Trace[i, j]

    if trace == 'd':
        sequence1_alignment += sequence1[i-1]
        sequence2_alignment += sequence2[j-1]
        i -= 1
        j -= 1
        
    elif trace == 'v':
        sequence1_alignment += sequence1[i-1]
        sequence2_alignment += '-'
        i -= 1
        
    elif trace == 'h':
        sequence1_alignment += '-'
        sequence2_alignment += sequence2[j-1]
        j -= 1

sequence1_alignment = sequence1_alignment[::-1]
sequence2_alignment = sequence2_alignment[::-1]


#=================================#
# Generate the identity alignment #
#=================================#
print('Calculating alignment identity...')
# This is just the bit between the two aligned sequences that
# denotes whether the two sequences have perfect identity
# at each position (a | symbol) or not.

identity_alignment = ''
for i in range(len(sequence1_alignment)):
	if sequence1_alignment[i] == sequence2_alignment[i]:
		identity_alignment += '|'
	else:
		identity_alignment += ' '

#===========================#
# Write alignment to output #
#===========================#
print('Writing output...')
# Certainly not necessary, but this writes 100 positions at
# a time to the output, rather than all of it at once.

with open(out_file, 'w') as output:
    
    for i in range(0, len(identity_alignment), 100):
    	output.write(sequence1_alignment[i:i+100] + '\n')
    	output.write(identity_alignment[i:i+100] + '\n')
    	output.write(sequence2_alignment[i:i+100] + '\n\n\n')


#=============================#
# Calculate sequence identity #
#=============================#

sequence1_identity = identity_alignment.count('|') / len(sequence1)
sequence2_identity = identity_alignment.count('|') / len(sequence2)

#======================#
# Print alignment info #
#======================#
print('Done!')
print(2*'\n')
# You need the number of gaps in each sequence, the sequence identity in
# each sequence, and the total alignment score

print(fasta_file)
print('Number of Gaps')
print('Sequence 1: ', sequence1_alignment.count('-'))
print('Sequence 2: ', sequence2_alignment.count('-'))
print(20*'-')

print('Percent Sequence Identity')
print('Sequence 1: ', sequence1_identity)
print('Sequence 2: ', sequence2_identity)
print(20*'-')

print('Alignment Score: ', F_matrix[-1, -1])
print(2*'\n')