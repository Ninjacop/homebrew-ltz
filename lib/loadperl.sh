#!/bin/bash

source $HOME/ltz/lib/loaddocs.sh


function perl-folders ()
{
    cd $HOME 
    if [ ! -d $Name ]
    then 
        echo ""
        echo "What is the name of your module?"

        read Module

            if [[ $Module == "" ]] 
            then 
                echo "Unable to create project \"$Name\""
                echo ""

            else
                mkdir $Name 
                cd $Name 
                
                mkdir t doc
                mkdir -p lib/$Name/$Module
                
                cd lib/$Name/$Module
                perl-modpm
                cd ..
                cd ..
                cd ..

                cd t 
                test-modpm
                cd ..
                
                cd doc 
                intro $Name 
                cd ..

                readme $Name 
                changelog
                gpl3-license
                perl-gitignore
                perl-make 

        fi
    fi
}

function perl-gitignore ()
{
    echo "!Build/
    .last_cover_stats
    /META.yml
    /META.json
    /MYMETA.*
    *.o
    *.pm.tdy
    *.bs

    # Devel::Cover
    cover_db/

    # Devel::NYTProf
    nytprof.out

    # Dizt::Zilla
    /.build/

    # Module::Build
    _build/
    Build
    Build.bat

    # Module::Install
    inc/

    # ExtUtils::MakeMaker
    /blib/
    /_eumm/
    /*.gz
    /Makefile
    /Makefile.old
    /MANIFEST.bak
    /pm_to_blib
    /*.zip" > .gitignore
}

function perl-make ()
{
    echo "    use ExtUtils::MakeMaker;
    WriteMakefile(
        NAME            => '$Name::$Module',
        VERSION_FROM    => 'lib/$Name/$Module/$Name.pm'
        );" > Makefile.PL
}

function perl-manifest-skip ()
{
    echo "    ~$          # ignore emacs and vim backup files
    .bak$       # ignore manual backups
    \#          # ignore CVS old revision files and emacs temp files" > MANIFEST.SKIP
}

function perl-manifest ()
{
    echo "Makefile.PL
        MANIFEST
        lib/$Name/$Module/$Name.pm" > MANIFEST
}

function perl-modpm ()
{
    echo " " > $Name.pm
}

function test-modpm ()
{
    echo " " > test.t
}