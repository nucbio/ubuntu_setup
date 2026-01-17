repos = list(CRAN="http://cran.rstudio.com/")

## BIOCONDUCTOR PACKAGES
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager", repos = repos)
# devel version
BiocManager::install(ask = FALSE)
BiocManager::valid()              # checks for out of date packages

BiocManager::install(
  c(
    'GenomicRanges',
    'BiocGenerics',
    'TxDb.Scerevisiae.UCSC.sacCer3.sgdGene',
    'BSgenome.Scerevisiae.UCSC.sacCer3',
    'rtracklayer',
    'Rsamtools'
   ), ask = FALSE)     
BiocManager::install(ask = FALSE)              # update packages

## CRAN PACKAGES
install.packages(
  c(
    'devtools',       # development packange (also knitr, roxygen, markdown)
    'tidyverse',      # data manipulation
    'data.table',     # data manipulation
    'e1071',          # stat functions
    'corrplot',       # ggplot extension
    'cowplot',        # ggplot extension
    'RColorBrewer',   # ggplot extension
    'colorRamps',     # ggplot extension 
    'GGally',         # ggplot extension
    'languageserver'  # r for GUI tools
   ), dependencies = TRUE, repos = repos)
   
# Laboratory Packages
# Install the packages from GitLab 
devtools::install_gitlab("mglab/loci") 
devtools::install_gitlab("mglab/seqtools") 
devtools::install_gitlab("mglab/fiber")
