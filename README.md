# Go Basebuild image

I like to compress go outputed executables as well as compile them staticaly.

This image is based on official golang image and will add:
  - musl to compile staticaly
  - upx to compress executables

## musl

To staticaly compile binaries with go:

  > # musl-gcc must be in the path
  > CC=musl-gcc CCGLAGS="-static" go build -ldflags '-linkmode external -s -w -extldflags "-static"' -a .

## upx

To compress executables with upx

  > # $executable is the path to the binary file
  > upx -qq --best $executable
