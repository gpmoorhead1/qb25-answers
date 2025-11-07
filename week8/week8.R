library(DESeq2)
library(tidyverse)
library(broom)

gene_locations <- read_delim("/Users/cmdb/Desktop/qb_data/gene_locations.txt")
counts_df <- read_delim("/Users/cmdb/Desktop/qb_data/gtex_whole_blood_counts_downsample.txt")
metadata_df <- read_delim("/Users/cmdb/Desktop/qb_data/gtex_metadata_downsample.txt")

# move the gene IDs to row names
counts_df <- column_to_rownames(counts_df, var = "GENE_NAME")
counts_df[1:5,]

metadata_df[1:5,]
metadata_df <- column_to_rownames(metadata_df, var = "SUBJECT_ID")

# check to make sure the metadata correspond to the count 
table(colnames(counts_df) == rownames(metadata_df))

# create DESeq2 object
dds <- DESeqDataSetFromMatrix(countData = counts_df,
                              colData = metadata_df,
                              design = ~ SEX + DTHHRDY + AGE)

# apply VST transformation
vsd <- vst(dds)

# pca plots

plotPCA(vsd, intgroup = "SEX")
ggsave("/Users/cmdb/git/qb25-answers/week8/sex_pca.png")

plotPCA(vsd, intgroup = "DTHHRDY")
ggsave("/Users/cmdb/git/qb25-answers/week8/dthhrdy_pca.png")

plotPCA(vsd, intgroup = "AGE")
ggsave("/Users/cmdb/git/qb25-answers/week8/age_pca.png")

# PC1 explains 48% of the variance while PC2 explains 7% of the variance
# PC1 appears to correlate strongly with death classification
# PC2 appears to partially correlate with sex


## Problem 2

vsd_df <- assay(vsd) %>%
  t() %>%
  as_tibble()

vsd_df <- bind_cols(metadata_df, vsd_df)

m1 <- lm(formula = WASH7P ~ DTHHRDY + AGE + SEX, data = vsd_df) %>%
  summary() %>%
  tidy()

# WASH7P is not significantly associated with sex (p=.279) which is not low enough to be 
# confident that the null model is incorrect

m2 <- lm(formula = SLC25A47 ~ DTHHRDY + AGE + SEX, data = vsd_df) %>%
  summary() %>%
  tidy()

# SLC25A47 is significantly associated with sex (p=.00257, which is less than the significance 
# threshold of .05), and is positively associated with males (coefficient of Sexmale is .518)

# 2.2

dds <- DESeq(dds)

res <- results(dds, name = "SEX_male_vs_female")  %>%
  as_tibble(rownames = "GENE_NAME")

de_res <- res %>% filter(padj < .1)
dim(de_res)
# there are 262 DE genes at <.1

left_join(de_res, gene_locations, by='GENE_NAME') %>% arrange(padj)

# all of the top 10 hits are from chrY and are upregulated in males. This makes sense because
# chrY is unique to males, whereas chrX is present in both males and females.

res %>% filter(GENE_NAME == "WASH7P")
res %>% filter(GENE_NAME == "SLC25A47")
# WASH7P is not significantly differentially expressed while SLC25A47 is, which is broadly 
# consistent with the results from naive regression.

# A very stringent FDR threshold will limit false positives while increasing 
# the number of false negatives, whereas using a lenient FDR threshold will increase the 
# number of false positives while decreasing the number of false negatives.
# Increased sample size will increase the power to detect true positives and limit
# noise that contributes to false positive, and will also increase the power to detect
# significant genes of lower effect sizes.


# 2.4
death_res <- results(dds, name = "DTHHRDY_ventilator_case_vs_fast_death_of_natural_causes")  %>%
  as_tibble(rownames = "GENE_NAME")

death_de <- death_res %>% filter(padj < .1)
dim(death_de)
# there are 16069 significantly differentially expressed genes.


meta_shuffle <- metadata_df
meta_shuffle$SEX <- sample(meta_shuffle$SEX)

# create DESeq2 object
shuffle_dds <- DESeqDataSetFromMatrix(countData = counts_df,
                              colData = meta_shuffle,
                              design = ~ SEX + DTHHRDY + AGE)

shuffle_dds <- DESeq(shuffle_dds)

shuffle_res <- results(shuffle_dds, name = "SEX_male_vs_female")  %>%
  as_tibble(rownames = "GENE_NAME")

shuffle_res <- shuffle_res %>% filter(padj < .1)
dim(shuffle_res)

left_join(shuffle_res, gene_locations, by='GENE_NAME') %>% arrange(padj)


# There are 36 differentially expressed genes in this false positive test. This means that 
# at an FDR threshold of .1 for this sample size, ~10% of positive genes are false positives
# for the sex variable.

res$Differentially_Expressed <- res$padj<.1 & res$log2FoldChange>1

ggplot(data = res, aes(x = log2FoldChange, y = -log10(pvalue), color=Differentially_Expressed)) +
  geom_point() +
  theme_classic()
ggsave("/Users/cmdb/git/qb25-answers/week8/volcano.png")

