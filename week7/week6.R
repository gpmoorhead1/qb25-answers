library(tidyverse)
library(matrixStats)
library(forcats)

df <- as.matrix(read.csv('/Users/cmdb/git/qb25-answers/week6/read_matrix.tsv', sep='\t'))

# 1.1 Loading and filtering data
pca_genes <- names(sort(rowSds(df), decreasing=TRUE)[0:500])
pca_df <- t(df[pca_genes, ])

# 1.2 run pca
pca_norm = pca_df %>% scale()
pca_results = prcomp(pca_norm)
summary(pca_results)

PC_data <- tibble(PC1=pca_results$x[, "PC1"], PC2=pca_results$x[, "PC2"], sample=rownames(pca_results$x))
PC_data <- separate(PC_data, sample, into=c("tissue", "replicate"), sep="_", remove=FALSE)

# 1.3 plotting
PC_data %>% ggplot(aes(PC1, PC2, color=tissue, shape=replicate)) +
  geom_point(size=4) +
  theme_classic()
ggsave('/Users/cmdb/git/qb25-answers/week6/original_pca_plot.png')

## fixing data and rerunning pca
df <- read.csv('/Users/cmdb/git/qb25-answers/week6/read_matrix.tsv', sep='\t')
df <- rename(df, LFC.Fe_Rep3=Fe_Rep1, Fe_Rep1=LFC.Fe_Rep3)
df <- as.matrix(df)

pca_genes <- names(sort(rowSds(df), decreasing=TRUE)[0:500])
pca_df <- t(df[pca_genes, ])

pca_norm = pca_df %>% scale()
pca_results = prcomp(pca_norm)

PC_data <- tibble(PC1=pca_results$x[, "PC1"], PC2=pca_results$x[, "PC2"], sample=rownames(pca_results$x))
PC_data <- separate(PC_data, sample, into=c("tissue", "replicate"), sep="_", remove=FALSE)

PC_data %>% ggplot(aes(PC1, PC2, color=tissue, shape=replicate)) +
  geom_point(size=4) +
  theme_classic()
ggsave('/Users/cmdb/git/qb25-answers/week6/fixed_pca_plot.png')

## creating scree plot
pca_var <- tibble(Variance_Explained=pca_results$sdev, PC=colnames(pca_results$x))
ggplot(data=pca_var, aes(y=Variance_Explained, x=fct_reorder(PC, desc(Variance_Explained)))) +
  geom_col() +
  labs(y="Amount of Variance Explained", x="Principal Component") +
  theme_classic()
ggsave('/Users/cmdb/git/qb25-answers/week6/pca_scree_plot.png')


# 2.1 averaging and filtering genes by variance

# in order for averaging code to work with my fixed data, have to change order of columns
colname_order <- sort(colnames(df))
df <- df[, colname_order]

# take average across replicates
combined = df[,seq(1, 21, 3)]
combined = combined + df[,seq(2, 21, 3)]
combined = combined + df[,seq(3, 21, 3)]
combined = combined / 3

# take genes with std > 1
k_genes <- names(rowSds(combined)[rowSds(combined) > 1])
k_df <- df[k_genes, ]
k_norm = k_df %>% scale()

set.seed(42)

kmeans_results <- kmeans(k_norm, centers=12, nstart=100)

ordering = order(kmeans_results$cluster)
heatmap(as.matrix(k_norm)[ordering,], Rowv=NA, Colv=NA,
        RowSideColors=RColorBrewer::brewer.pal(12, name="Paired")[kmeans_results$cluster[ordering]], scale='none')
ggsave('/Users/cmdb/git/qb25-answers/week6/kmeans_heatmap.png')

## Exercise 3
# get gene names for cluster 1 and 2

cluster11_genes <- names(kmeans_results$cluster[kmeans_results$cluster==11])
cat(cluster11_genes, sep='\n')

cluster2_genes <- names(kmeans_results$cluster[kmeans_results$cluster==2])
cat(cluster2_genes, sep='\n')
