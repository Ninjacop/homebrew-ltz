#!/bin/bash

source $HOME/ltz/lib/loaddocs.sh

function sql-folders ()
{
    cd $HOME 
    if [ ! -d $Name ]
    then
        mkdir $Name 
        cd $Name 

        mkdir tables views stored-procedures functions synonyms types assemblies doc
        
        cd doc 
        intro $Name 
        cd ..

        sql-gitignore
        readme $Name
        changelog
        gpl3-license
    else 
     echo "ERROR: Project folder \"$Name\" already exists. Delete the existing folder or make a new Project under a different name"
    fi
}

function sql-gitignore ()
{
    echo "
    # Compiled source 
    
    *.com
    *.class
    *.dll
    *.exe
    *.o
    *.so

    # Packages 
     
    # it's better to unpack these files and commit the raw source
    # git has its own built in compression methods
    *.7z
    *.dmg
    *.gz
    *.iso
    *.jar
    *.rar
    *.tar
    *.zip

    # Logs and databases 
    
    *.log
    *.sql
    *.sqlite

    # OS generated files 

    .DS_Store
    .DS_Store?
    ._*
    .Spotlight-V100
    .Trashes
    ehthumbs.db
    Thumbs.db" > .gitignore
}