# Miniproject 2 on Codon Usage

Translate codons to amino acids and compare amino acid composition between sequences.


## Step 2
After step 1, codon-usage.py successfully prints out the contig followed by a 3 letter string representing a codon.


## Step 3
- Results for cytoplasm.fa:

{'*': 100, 'A': 3183, 'C': 954, 'D': 2252, 'E': 3544, 'F': 1610, 'G': 2663, 'H': 1273, 'I': 1907, 'K': 2570, 'L': 4769, 'M': 988, 'N': 1704, 'P': 2762, 'Q': 2166, 'R': 2622, 'S': 3808, 'T': 2633, 'V': 2525, 'W': 535, 'Y': 1201}

- Results for membrane.fa:

{'*': 100, 'A': 3364, 'C': 1031, 'D': 2039, 'E': 2953, 'F': 1961, 'G': 3143, 'H': 1224, 'I': 2365, 'K': 2207, 'L': 5044, 'M': 1010, 'N': 1797, 'P': 3053, 'Q': 1879, 'R': 2511, 'S': 4272, 'T': 3468, 'V': 2921, 'W': 595, 'Y': 1438}


There are differing amounts of hydrophobic and hydrophylic proteins. One would expect to see more hydophobic aa's in the membrane as compared to the cytoplasm, and we see that there are a higher number of hydrophobic aa's like isoleucine, leucine, and valine in the membrane as compared to the cytoplasm.