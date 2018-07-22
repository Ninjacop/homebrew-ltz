# ltz

An all purpose, simple, lightweight CLT that helps create projects on the fly
    
## Installation - This only works on Mac/Linux right now!

### First Method - Git
1. Clone this repo into your Home directory

        $ git clone github.com/Ninjacop/ltz.git

3. Go into terminal and type these commands

        $ cd ~/ltz/bin

        $ open ltz

This will open a seperate Terminal window, so once it is done, quit out of terminal (Command-Q for all who don't remember)

4. Open up a new terminal window and you're all set and ready to go!

### Second Method - Downloading the .zip
1. So if you don't have git, you can download a zip of the current build

2. Unzip the build in your Home directory 

3. Go into terminal and type these commands

        $ cd ~/ltz/bin

        $ open ltz

This will open a seperate Terminal window, so once it is done, quit out of terminal (Command-Q for all who don't remember)

4. Open up a new terminal window and you're all set and ready to go!
  
## Usage
    
Open a terminal window and type in the below code

        $ ltz  x  y 

x is the programming language you want the project to be in

y is the name of the project 
    
## Options
    
As of v1.0.3, you can only generate projects in these langauges (not case sensitive):

- C++ (You have to type in Cplus/cplus because "C++" and "Cpp" are reserved)
- C
- Java
- Javascript
- Python (Both 2.x and 3.x)
- Bash
- SQL
- Ruby
- Swift
      
## Examples  
      
        $ project bash example

        Generating folders...
        done.

        Created bash project at ~/Users/Name/example
      
### Bugs  
      
#### Fixed as of 1.0.4
- Files and folders were being created not inside a project folder and spilling all over the Home directory
      
## License  
      
Copyright © 2018 Ninjacop

Protected by GNU General Public License 3.0 (GNU GPL v3)

See LICENSE for in-depth detail

