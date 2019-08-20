# Tensors.jl
Testing out a design for ITensor using an internal Tensor type.

The Tensor class is meant to have a Julia AbstractArray interface, but with 
various types of storage and indices (i.e. the storage could be Diag or BlockSparse
and the indices could be tuples of integers or ITensor Indices).

ITensor functions are written by creating Tensor objects from their storage
and indices and then calling Tensor functions, using a function-barrier
approach.
