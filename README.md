# Go Basebuild image

I like to compress go outputed executables as well as compile them staticaly.

This image is based on official golang image and will add:
  - upx to compress executables

## upx

To compress executables with upx

  > # $executable is the path to the binary file
  > upx -qq --best $executable
