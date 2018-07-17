#!/bin/bash

source $HOME/ltz/lib/loaddocs.sh

function java-folders ()
{
    if [[ ! -d $Name ]]
    then
        cd $HOME
        mkdir $Name
        cd $Name

        mkdir -p src/main/java/com/$Name/app
        mkdir -p src/main/resources
        mkdir -p src/main/filters
        mkdir -p src/main/webapp
        mkdir -p src/test/resources
        mkdir -p src/test/java/com/$Name/app
        mkdir -p src/test/filters 
        mkdir -p src/it  
        mkdir -p src/assembly
        mkdir -p src/site 
        mkdir target

        cd doc 
        intro $Name 
        cd ..

        changelog
        gpl3-license
        java-gitignore
        readme $Name
        mkdir doc
        java-pom

    else
        echo "ERROR: Project folder \"$Name\" already exists. Delete the existing folder or make a new Project under a different name"
    fi
}


function java-pom ()
{
    echo "<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    
    <groupId>com.$Name.app</groupId>
    <artifactId>$Name</artifactId>
    <version>1.0-SNAPSHOT</version>
    <packaging>jar</packaging>
    
    <name>Maven Quick Start Archetype</name>
    <url>http://maven.apache.org</url>
    
    <dependencies>
        <dependency>
        <groupId>junit</groupId>
        <artifactId>junit</artifactId>
        <version>4.8.2</version>
        <scope>test</scope>
        </dependency>
    </dependencies>
    </project> " > pom.xml
}


function java-gitignore ()
{
    echo "# Compiled class file
    *.class

    # Log file
    *.log

    # BlueJ files
    *.ctxt

    # Mobile Tools for Java (J2ME)
    .mtj.tmp/

    # Package Files #
    *.jar
    *.war
    *.nar
    *.ear
    *.zip
    *.tar.gz
    *.rar

    # OS generated files 

    .DS_Store
    .DS_Store?
    ._*
    .Spotlight-V100
    .Trashes
    ehthumbs.db
    Thumbs.db

    # virtual machine crash logs, see http://www.java.com/en/download/help/error_hotspot.xml
    hs_err_pid*" > .gitignore 
}