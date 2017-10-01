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
LABEL description = "HelloWorld in C"
LABEL version = "0.1"
COPY HelloWorld /
CMD ["/HelloWorld"]
EOF

# Clean up
rm HelloWorld.c

echo ""
echo "Example to build and push to Docker Hub"
echo "---------------------------------------"
echo "docker build -t bymoln/helloworld-c ."
echo "docker login"
echo "docker push bymoln/helloworld-c"
echo ""

