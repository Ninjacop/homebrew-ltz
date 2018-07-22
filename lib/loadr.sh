#!/bin/bash

source $HOME/ltz/lib/loaddocs.sh


function r-folders ()
{
    if [[ ! -d $Name ]]
    then
        cd $Name
        mkdir $Name
        cd $Name

        mkdir R data doc figs output src doc

        cd doc 
        intro $Name
        cd ..

        r-gitignore 
        readme $Name
        changelog 
        gpl3-license
    fi
}


function r-gitignore ()
{
    echo "# History files
    .Rhistory
    .Rapp.history

    # Session Data files
    .RData

    # Example code in package build process
    *-Ex.R

    # Output files from R CMD build
    /*.tar.gz

    # Output files from R CMD check
    /*.Rcheck/

    # RStudio files
    .Rproj.user/

    # produced vignettes
    vignettes/*.html
    vignettes/*.pdf

    # OAuth2 token, see https://github.com/hadley/httr/releases/tag/v0.3
    .httr-oauth

    # knitr and R markdown default cache directories
    /*_cache/
    /cache/

    # Temporary files created by R markdown
    *.utf8.md
    *.knit.md

    # Shiny token, see https://shiny.rstudio.com/articles/shinyapps.html
    rsconnect/" > .gitignore
}