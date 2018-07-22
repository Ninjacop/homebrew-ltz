#!/bin/bash

source $HOME/ltz/lib/loaddocs.sh

function asm-folders ()
{
    if [[ ! -d $Name ]]
    then
        cd $Name
        mkdir $Name
        cd $Name
    
        mkdir -p iso/boot/grub
        mkdir -p reference/src
        mkdir src doc
        
        cd iso/boot/grub
        asm-grub
        cd reference

        asm-src-make
        cd ..
        
        cd doc 
        intro $Name 
        cd ..

        readme $Name 
        changelog
        gpl3-license
        asm-gitignore
        asm-make
    fi
}


function asm-grub ()
{
    echo "menuentry \"$Name\" {
    multiboot /boot/$Name.bin
    }" > grub.cfg
}


function asm-gitignore ()
{
    echo "
    *.o
    *.d
    *.iso
    *.bin 
    *.elf " > .gitignore
}


function asm-make ()
{
    echo "CC=i686-pc-elf-gcc
    LD=i686-pc-elf-ld
    ASM=nasm

    CFLAGS:=-std=c99 -MMD
    CFLAGS+=-m32
    CFLAGS+=-g -ggdb
    CFLAGS+=-O3 -ffast-math
    CFLAGS+=-ffreestanding -nostdlib -nostdinc -fno-builtin -nostartfiles -nodefaultlibs -fno-exceptions -fno-stack-protector -static -fno-pic

    LDFLAGS=-m elf_i386
    LDLIBS=

    ASMFLAGS=-felf -isrc/
    ASMFLAGS+=-g

    CSRCS=\$(wildcard src/*.c)
    ASMSRCS=\$(wildcard src/*.asm)
    OBJS=\$(CSRCS:.c=.o) \$(ASMSRCS:.asm=.o)
    DEPS=\$(OBJS:.o=.d)

    .PHONY: all clean

    all: $Name.bin $Name.elf

    # NOTE: linker script must be first dependency
    $Name.%: src/%.ld \$(OBJS)
        \$(LD) \$(LDFLAGS) -o \$@ -T \$^ \$(LDLIBS)

    %.o: %.asm
        \$(ASM) \$(ASMFLAGS) -MD \$(@:.o=.d) -o \$@ \$<

    -include \$(DEPS)

    # Test in QEMU

    test: $Name.bin
        qemu-system-i386 -kernel $Name.bin

    .PHONY: test

    # Target for producing ISO image

    iso: $Name.iso
    $Name.iso: $Name.bin
        cp $Name.bin iso/boot/$Name.bin
        grub-mkrescue -o $Name.iso iso

    .PHONY: iso

    # Clean up

    clean:
        rm -f \$(OBJS)
        rm -f \$(DEPS)
        rm -f $Name.bin
        rm -f $Name.elf
        rm -f $Name.iso
        rm -f iso/boot/$Name.bin " > Makefile
}


function asm-src-make ()
{
    echo "
    CC = gcc
    CFLAGS = -O3 -Wall -Werror

    bin:
        mkdir -p bin

    test:
        bin/$Name

    clean:
        rm -rf bin" > Makefile
}