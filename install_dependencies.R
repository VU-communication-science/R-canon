
## Install renv and yaml. This allows using
## renv::dependencies(), which lists all the 
## packages referred to in all Quarto files.

if (!require('renv', quietly = T)) install.packages('renv')
if (!require('yaml', quietly = T)) install.packages('yaml')
  
## Get the unique package names
deps <- renv::dependencies()
udeps <- unique(deps$Package)

udeps <- udeps[!udeps %in% c('renv','yaml')]

## Install
install.packages(udeps)

