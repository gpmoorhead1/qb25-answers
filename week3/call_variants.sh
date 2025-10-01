# 1.1
samtools index -M  ./BYxRM_bam/*

echo "Read Counts" > read_counts.txt
for bam in A01_09.bam A01_11.bam A01_23.bam A01_24.bam A01_27.bam A01_31.bam A01_35.bam A01_39.bam A01_62.bam A01_63.bam
do
    samtools view -c ./BYxRM_bam/$bam >> read_counts.txt
done

# 1.2
ls BYxRM_bam | grep -v bai > bamListFile.txt

# ran in bam directory
freebayes -f /Users/cmdb/git/qb25-answers/week2/genomes/sacCer3.fa -L ../bamListFile.txt --genotype-qualities -p 1 > unfiltered.vcf
vcffilter -f "QUAL > 20" -f "AN > 9" unfiltered.vcf > filtered.vcf

