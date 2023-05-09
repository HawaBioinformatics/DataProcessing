# Location of packages download
if (!requireNamespace("BiocManager", quietly = TRUE)) {
  install.packages("BiocManager")
}

BiocManager::install("quantiseqr")

###
library("quantiseqr")
library("dplyr")
library("ggplot2")
library("tidyr")
library("tibble")
library("GEOquery")
library("reshape2")
library("SummarizedExperiment")

###
### LOADING DATASET
dataSM1 <- read.csv("/Users/hawacoulibaly/Desktop/SM1 combination study/DATA/SM1_TPM_all_average.csv", row.names='Genes')
dim(dataSM1)
# > [1] 55715     2
knitr::kable(dataSM1[1:5, ])

###
### The quantification of the immune cell types with quantiseqr

ti_racle <- quantiseqr::run_quantiseq(
  expression_data = dataSM1,
  signature_matrix = "TIL10",
  is_arraydata = FALSE,
  is_tumordata = TRUE,
  scale_mRNA = TRUE
)

## Running quanTIseq deconvolution module

#> Gene expression normalization and re-annotation (arrays: FALSE)

#> Removing 17 noisy genes

#> Removing 15 genes with high expression in tumors

#> Signature genes found in data set: 121/138 (87.68%)

#> Mixture deconvolution (method: lsei)

#> Deconvolution successful!

quantiplot(ti_racle)

###
dim(ti_racle)
# [1]  2 12
colData(ti_racle)
colnames(colData(ti_racle))