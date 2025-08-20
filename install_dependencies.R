
## Install renv and yaml. This allows using
## renv::dependencies(), which lists all the 
## packages referred to in all Quarto files.
if (!length(find.package('renv', quiet = T))) install.packages('renv')
if (!length(find.package('yaml', quiet = T))) install.packages('yaml')
  
## Get the unique package names
deps <- renv::dependencies()
udeps <- unique(deps$Package)

cat("Book currently uses the following packages:\n", 
    paste(paste('-', udeps), collapse='\n'))

## Install
install.packages(udeps)


