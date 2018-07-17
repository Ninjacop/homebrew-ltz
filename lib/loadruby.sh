#!/bin/bash

source $HOME/ltz/lib/loaddocs.sh

function ruby-folders ()
{
    cd $HOME 
    if [ ! -d $Name ]
    then
        mkdir $Name 
        cd $Name

        mkdir bin doc data ext lib tests

        cd doc 
        intro $Name 
        cd ..

        cd tests 
        ruby-tests
        cd ..

        cd lib 
        ruby-module
        cd ..

        touch bin/$Name

        ruby-gemspec
        ruby-rakefile

        readme $Name
        changelog
        gpl3-license
        ruby-gitignore 
    else 
     echo "ERROR: Project folder \"$Name\" already exists. Delete the existing folder or make a new Project under a different name"
    fi
}

function ruby-module ()
{
    echo " " > $Name.rb
}

function ruby-gemspec ()
{
    echo "# coding: utf-8
    lib = File.expand_path('../lib', __FILE__)
    $LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

    Gem::Specification.new do |spec|
    spec.name          = "$Name"
    spec.version       = '1.0'
    spec.authors       = ["$USER"]
    spec.email         = [\"youremail@domain.com\"]
    spec.summary       = %q{Short summary of your project}
    spec.description   = %q{Longer description of your project.}
    spec.homepage      = \"http://domainforproject.com/\"
    spec.license       = \"GNU GPLv3\"

    spec.files         = ['lib/$NAME.rb']
    spec.executables   = ['bin/$NAME']
    spec.test_files    = ['tests/test_$NAME.rb']
    spec.require_paths = [\"lib\"]
    end" > $Name.gemspec
}

function ruby-rakefile ()
{
    echo "require 'rake/testtask'

    Rake::TestTask.new do |t|
    t.libs << \"tests\"
    t.test_files = FileList['tests/test*.rb']
    t.verbose = true
    end" > Rakefile
}

function ruby-tests ()
{
    echo "require \"$Name/lib/NAME.rb\"
    require \"test/unit\"

    class TestNAME < Test::Unit::TestCase

    def test_sample
        assert_equal(4, 2+2)
    end

    end" > tests_$Name.rb
}

function ruby-gitignore ()
{
    echo "*.gem
    *.rbc
    /.config
    /coverage/
    /InstalledFiles
    /pkg/
    /spec/reports/
    /spec/examples.txt
    /test/tmp/
    /test/version_tmp/
    /tmp/

    # Used by dotenv library to load environment variables.
    # .env

    ## Specific to RubyMotion:
    .dat*
    .repl_history
    build/
    *.bridgesupport
    build-iPhoneOS/
    build-iPhoneSimulator/

    ## Specific to RubyMotion (use of CocoaPods):
    #
    # We recommend against adding the Pods directory to your .gitignore. However
    # you should judge for yourself, the pros and cons are mentioned at:
    # https://guides.cocoapods.org/using/using-cocoapods.html#should-i-check-the-pods-directory-into-source-control
    #
    # vendor/Pods/

    ## Documentation cache and generated files:
    /.yardoc/
    /_yardoc/
    /doc/
    /rdoc/

    ## Environment normalization:
    /.bundle/
    /vendor/bundle
    /lib/bundler/man/

    # for a library or gem, you might want to ignore these files since the code is
    # intended to run in multiple environments; otherwise, check them in:
    # Gemfile.lock
    # .ruby-version
    # .ruby-gemset

    # unless supporting rvm < 1.11.0 or doing something fancy, ignore this:
    .rvmrc
    
    # OS generated files 
    .DS_Store
    .DS_Store?
    ._*
    .Spotlight-V100
    .Trashes
    ehthumbs.db
    Thumbs.db" > .gitignore
}