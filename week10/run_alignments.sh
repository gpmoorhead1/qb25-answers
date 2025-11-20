#!/bin/bash

/opt/anaconda3/envs/qb25/bin/python assignment_framework.py \
    CTCF_38_M27_DNA.fna \
    HOXD70.txt \
    -10 \
    ./dna_alignment.out


/opt/anaconda3/envs/qb25/bin/python assignment_framework.py \
    CTCF_38_M27_AA.faa \
    BLOSUM62.txt \
    -10 \
    ./aa_alignment.out