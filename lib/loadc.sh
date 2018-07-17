#!/bin/bash

source $HOME/ltz/lib/loaddocs.sh

function c-folders ()
{
    cd $HOME 
    if [ ! -d $Name ]
    then
        mkdir bin
        mkdir src 
        mkdir tests
        mkdir doc

        cd src 
        c-main
        c-src-makefile
        cd ..

        cd tests 
        c-tests-makefile
        cd ..

        cd doc 
        intro $Name 
        cd ..

        c-gitignore
        c-makefile
        readme $Name
        changelog
        gpl3-license
    else 
     echo "ERROR: Project folder \"$Name\" already exists. Delete the existing folder or make a new Project under a different name"
    fi
}

function c-gitignore ()
{
    echo "# Object files
    *.o
    *.ko
    *.obj
    *.elf

    # Precompiled Headers
    *.gch
    *.pch

    # Libraries
    *.lib
    *.a
    *.la
    *.lo

    # Shared objects (inc. Windows DLLs)
    *.dll
    *.so
    *.so.*
    *.dylib

    # Executables
    *.exe
    *.out
    *.app
    *.i*86
    *.x86_64
    *.hex

    # Debug files
    *.dSYM/
    *.su

    # Own
    *.p
    *.sp
    *.d
    src/tmp
    *.map

    # Compiled source 
    
    *.com
    *.class  

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

    # OS generated files 

    .DS_Store
    .DS_Store?
    ._*
    .Spotlight-V100
    .Trashes
    ehthumbs.db
    Thumbs.db" > .gitignore
}

function c-top-makefile ()
{
    echo " # IMPORTANT variables
    PROGRAMNAME=$Name
    SOURCES=main.c

    #locations
    SRCDIR=	src
    OUTDIR=	bin
    TESTDIR=tests

    OBJECTS= \$(addprefix \$(SRCDIR)/, \$(SOURCES:.c=.o))
    PROGRAM= \$(addprefix \$(OUTDIR)/, \$(PROGRAMNAME))

    WARNINGS= -W -Wall -ansi -Wextra -pedantic -Wstrict-overflow=5 -Wshadow -Wpointer-arith -Wcast-qual -Wstrict-prototypes # turn on all possible warnings
    COMPILER= -std=gnu89 # -s -march=native -flto -mtune=native -Os -Ofast -ffunction-sections -fdata-sections 		# strip, optimize for performance and then (mainly) for size. After that place all functions and data to separate sections
    LINKER= # -flto -Wl,-Map=\$(PROGRAM).map,--cref,--gc-section -Wl,--build-id=none		# and with linker delete unneeded ones
    DEBUG= -g

    export SOURCES
    export DEBUG
    export COMPILER
    export WARNINGS

    all:\ $(PROGRAM)

    .PHONY: objects clean
    objects:
        \$(MAKE) -C \$(SRCDIR) all

    \$(PROGRAM): objects
        cc -o \$@ \$(OBJECTS) \$(DEBUG) \$(LINKER)
    #	strip -S --strip-all --remove-section=.note.gnu.gold-version --remove-section=.comment --remove-section=.note --remove-section=.note.gnu.build-id --remove-section=.note.ABI-tag $@

    clean:
        \$(MAKE) -C \$(SRCDIR) clean
        \$(MAKE) -C \$(TESTDIR) clean
        rm -f \$(PROGRAM) \$(PROGRAM).map" > Makefile
}

function c-src-makefile ()
{
    echo "# Variables. SOURCES is exported from makefile one folder up and so is DEBUG
    OBJECTS=\$(SOURCES:.c=.o)
    PROTO=\$(SOURCES:.c=.p)
    STATPROTO=\$(SOURCES:.c=.sp)
    DEPS=\$(SOURCES:.c=.d)

    # Generate and include dependencies:

    all: \$(DEPS) \$(OBJECTS)

    %.o: %.c %.d
        \$(CC) \$(WARNINGS) \$(DEBUG) \$(COMPILER) -c -o \$@ $<

    # Generate dependencies
    %.d: %.c
        \$(CC) -MM -MG -MF \$@ $<

    # Generate function prototypes
    %.p: %.c
        cproto $< > \$@

    .PHONY: clean

    clean:
        rm -f \$(OBJECTS) \$(DEPS) \$(PROTO) \$(STATPROTO)

    -include \$(DEPS)" > Makefile
}

function c-tests-makefile ()
{
    echo ".PHONY: clean

    clean:" > Makefile
}

function c-main ()
{
    echo " " > main.c
}