
# Forked from ilastik recipe for opengm

Building and using this package requires conda installed cmake and also some dependancies from ilastik. 

before building:

$ conda install cmake

When building:

$ conda build -c ilastik opengm

before installing:

$ conda install -c ilastik --use-local opengm