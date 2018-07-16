#!/bin/bash

source $HOME/ltz/lib/loaddocs.sh

function cpp-gitignore ()
{
    echo "# Ignore the build and lib dirs  
    build  
    lib/*  
    
    # Ignore any executables  
    bin/*  
    
    # Ignore Mac specific files  
    .DS_Store  
    # Prerequisites
    *.d

    # Compiled Object files
    *.slo
    *.lo
    *.o
    *.obj

    # Precompiled Headers
    *.gch
    *.pch

    # Compiled Dynamic libraries
    *.so
    *.dylib
    *.dll

    # Fortran module files
    *.mod
    *.smod

    # Compiled Static libraries
    *.lai
    *.la
    *.a
    *.lib

    # Executables
    *.exe
    *.out
    *.app" > .gitignore
}

function cpp-make ()
{
    echo "#  
    # TODO: Move \`libmongoclient.a\` to /usr/local/lib so this can work on production servers  
    #  
      
    CC := g++ # This is the main compiler  
    # CC := clang --analyze # and comment out the linker last line for sanity  
    SRCDIR := src  
    BUILDDIR := build  
    TARGET := bin/runner  
      
    SRCEXT := cpp  
    SOURCES := \$(shell find \$(SRCDIR) -type f -name *.\$(SRCEXT))  
    OBJECTS := \$(patsubst \$(SRCDIR)/%,\$(BUILDDIR)/%,\$(SOURCES:.\$(SRCEXT)=.o))  
    CFLAGS := -g # -Wall  
    LIB := -pthread -lmongoclient -L lib -lboost_thread-mt -lboost_filesystem-mt -lboost_system-mt  
    INC := -I include  
      
    \$(TARGET): \$(OBJECTS)  
    @echo \" Linking...\"  
    @echo \" \$(CC) $^ -o \$(TARGET) \$(LIB)\"; \$(CC) $^ -o \$(TARGET) \$(LIB)  
      
    \$(BUILDDIR)/%.o: \$(SRCDIR)/%.\$(SRCEXT)  
    @mkdir -p \$(BUILDDIR)  
    @echo \" \$(CC) \$(CFLAGS) \$(INC) -c -o \$@ $<\"; \$(CC) \$(CFLAGS) \$(INC) -c -o \$@ $<  
      
    clean:  
    @echo \" Cleaning...\";   
    @echo \" \$(RM) -r \$(BUILDDIR) \$(TARGET)\"; \$(RM) -r \$(BUILDDIR) \$(TARGET)  
      
    # Tests  
    tester:  
    \$(CC) \$(CFLAGS) test/tester.cpp \$(INC) \$(LIB) -o bin/tester  
      
    # Spikes  
    ticket:  
    \$(CC) \$(CFLAGS) spikes/ticket.cpp \$(INC) \$(LIB) -o bin/ticket  
      
    .PHONY: clean  " > makefile
}


function cpp-folders ()
{
    cd $HOME
    if [[ ! -d $Name ]]
    then
        mkdir $Name
        cd $Name

        mkdir bin
        mkdir build
        mkdir doc 
        mkdir include
        mkdir lib
        mkdir spike

        mkdir src
        cd src
        mkdir "Resource Files"
        mkdir "Template Files"
        mkdir "Header Files"
        cd ..

        mkdir test

        cd doc 
        intro $Name 
        cd ..
        
        cpp-gitignore
        cpp-make
        readme $Name
        changelog 
        gpl3-license
    else
        echo "ERROR: Project folder \"$Name\" already exists. Delete the existing folder or make a new Project under a different name"
    fi
    
}