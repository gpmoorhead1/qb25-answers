# Miniproject 2 on Codon Usage

Translate codons to amino acids and compare amino acid composition between sequences.


## Step 2
After step 1, codon-usage.py successfully prints out the contig followed by a 3 letter string representing a codon.


## Step 3
- Results for cytoplasm.fa:

{'M': 988, 'P': 2762, 'F': 1610, 'L': 4769, 'E': 3544, 'D': 2252, 'T': 2633, 'N': 1704, 'A': 3183, 'R': 2622, 'V': 2525, 'G': 2663, 'K': 2570, 'C': 954, 'S': 3808, 'I': 1907, 'Q': 2166, 'H': 1273, 'Y': 1201, '*': 100, 'W': 535}

- Results for membrane.fa:

{'M': 1010, 'A': 3364, 'E': 2953, 'S': 4272, 'R': 2511, 'G': 3143, 'L': 5044, 'Y': 1438, 'W': 595, 'C': 1031, 'F': 1961, 'V': 2921, 'I': 2365, 'K': 2207, 'P': 3053, 'T': 3468, 'H': 1224, 'Q': 1879, 'N': 1797, 'D': 2039, '*': 100}


There are differing amounts of hydrophobic and hydrophylic proteins. One would expect to see more hydophobic aa's in the membrane as compared to the cytoplasm, and we see that there are a higher number of hydrophobic aa's like isoleucine, leucine, and valine in the membrane as compared to the cytoplasm.