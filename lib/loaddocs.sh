#!/bin/bash

function changelog ()
{
    echo "# Change Log
    All notable changes to this project will be documented in this file. This change log follows the conventions of [keepachangelog.com](http://keepachangelog.com/).  

    ## [Unreleased]
    ### Changed
    - Ch-ch-changes!
    
    ## [0.1.1]
    ### Changed
    - Documentation on how to make the widgets.
    
    ### Removed
    - something not useful
    
    ### Fixed
    - a bug
    
    ## 0.1.0 
    ### Added
    - Files" > CHANGELOG.md
}

function readme ()
{
 echo "# $Name

FIXME: description
    
## Installation
    
Download from http://example.com/FIXME.
    
## Usage
    
FIXME: explanation
    
    
## Options
    
FIXME: listing of options this app accepts. 
      
## Examples  
      
...  
      
### Bugs  
      
...  
      
### Any Other Sections  
### That You Think  
### Might be Useful  
      
## License  
      
Copyright © 2018 FIXME  " > README.md
}

function intro ()
{
    echo "# Introduction to $Name
      
    TODO: write [great documentation](http://jacobian.org/writing/what-to-write/)  " > intro.md
}