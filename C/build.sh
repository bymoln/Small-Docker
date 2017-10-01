#!/bin/sh

# Create statically linked executable
cat << EOF > HelloWorld.c
#include <stdio.h>

int main(void)
{
  printf("Hi World!\n");
  return 0;
}
EOF

gcc -static HelloWorld.c -o HelloWorld

# Build docker image
cat << EOF > Dockerfile
FROM scratch
COPY HelloWorld /
CMD ["/HelloWorld"]
EOF

docker build -t bymoln/helloworld-c .

# Clean up
rm HelloWorld.c HelloWorld Dockerfile

