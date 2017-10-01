#!/bin/sh

# Create HelloWorld
cat << EOF > HelloWorld.nasm
global _start

section .text
_start:
	mov	eax, 4
	mov	ebx, 1
	mov	ecx, msg
	mov	edx, msg.len
	int	0x80

	mov	eax, 1
	mov	ebx, 0
	int	0x80

section .data
msg:	db	"Hi!", 10
.len:	equ	$ - msg
EOF

nasm -felf64 HelloWorld.nasm
ld HelloWorld.o -o HelloWorld
strip HelloWorld

# Build docker image
cat << EOF > Dockerfile
FROM scratch
LABEL description = "HelloWorld in ASM"
LABEL version = "0.1"
COPY HelloWorld /
CMD ["/HelloWorld"]
EOF

# Clean up
rm HelloWorld.{nasm,o}

echo ""
echo "Example to build and push to Docker Hub"
echo "---------------------------------------"
echo "docker build -t bymoln/helloworld-asm ."
echo "docker login"
echo "docker push bymoln/helloworld-asm"
echo ""

