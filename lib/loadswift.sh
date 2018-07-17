#!/bin/bash

source $HOME/ltz/lib/loaddocs.sh

function swift-folders ()
{
    cd $HOME 
    if [ ! -d $Name ]
    then
        mkdir $Name 
        cd $Name 

        mkdir controllers
        mkdir views 
        mkdir models 
        mkdir nibs 
        mkdir tools 
        mkdir resources
        mkdir doc 

        cd doc 
        intro $Name 
        cd ..

        gpl3-license 
        readme $Name 
        changelog
        swift-gitignore

    else 
        echo "ERROR: Project folder \"$Name\" already exists. Delete the existing folder or make a new Project under a different name"
    fi
}

function swift-gitignore ()
{
    echo "# Xcode
    #
    # gitignore contributors: remember to update Global/Xcode.gitignore, Objective-C.gitignore & Swift.gitignore

    ## Build generated
    build/
    DerivedData/

    ## Various settings
    *.pbxuser
    !default.pbxuser
    *.mode1v3
    !default.mode1v3
    *.mode2v3
    !default.mode2v3
    *.perspectivev3
    !default.perspectivev3
    xcuserdata/

    ## Other
    *.moved-aside
    *.xccheckout
    *.xcscmblueprint

    ## Obj-C/Swift specific
    *.hmap
    *.ipa
    *.dSYM.zip
    *.dSYM

    ## Playgrounds
    timeline.xctimeline
    playground.xcworkspace

    # Swift Package Manager
    #
    # Add this line if you want to avoid checking in source code from Swift Package Manager dependencies.
    # Packages/
    # Package.pins
    # Package.resolved
    .build/

    # CocoaPods
    #
    # We recommend against adding the Pods directory to your .gitignore. However
    # you should judge for yourself, the pros and cons are mentioned at:
    # https://guides.cocoapods.org/using/using-cocoapods.html#should-i-check-the-pods-directory-into-source-control
    #
    # Pods/
    #
    # Add this line if you want to avoid checking in source code from the Xcode workspace
    # *.xcworkspace

    # Carthage
    #
    # Add this line if you want to avoid checking in source code from Carthage dependencies.
    # Carthage/Checkouts

    Carthage/Build

    # fastlane
    #
    # It is recommended to not store the screenshots in the git repo. Instead, use fastlane to re-generate the
    # screenshots whenever they are needed.
    # For more information about the recommended setup visit:
    # https://docs.fastlane.tools/best-practices/source-control/#source-control

    fastlane/report.xml
    fastlane/Preview.html
    fastlane/screenshots/**/*.png
    fastlane/test_output
    
    # OS generated files 
 
    .DS_Store
    .DS_Store?
    ._*
    .Spotlight-V100
    .Trashes
    ehthumbs.db
    Thumbs.db" > .gitignore
}