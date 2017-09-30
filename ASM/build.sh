#!/bin/sh
nasm -felf64 HelloWorld.nasm
ld HelloWorld.o -o HelloWorld
strip HelloWorld

