## 1.1
How many 100bp reads are needed to sequence a 1Mbp genome to 3x coverage?
- 1 Mbp (1,000,000bp) * 3 / 100 = 30,000 reads


## 1.4
- 4.9% of the genome has not been sequenced.
- This seems to match the poisson distribution quite well, whereas the normal distribution doesn't match as well.

## 1.5
- .86% of the genome doesn't have any coverage
- Both the poisson and normal distributions match the data, however the poisson matches slightly better.

## 1.6
- .12% of the genome has 0 coverage
- Both the poisson and normal distributions fit the data well

# Exercise 2

Command for running dot:

`dot -Tpng debruijn_input.txt > ex2_digraph.png`

Possible sequence:
- ATT TTG TGA GAT ATT TTC TCA CAT ATT TTC TCT CTT TTA TAT ATT TTT


There are clearly identified sequential motifs but we don't know the order of them. Longer reads would solve the problem.