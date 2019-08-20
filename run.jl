include("itensor.jl")

#
# Test the Tensor class
#

TA = Tensor(Dense([1 2; 3 4]),(2,2))
TB = Tensor(Diag([1,2]),(2,2))

@show TA[1,2] == 2
@show TB[2,2] == 2
@show TB[1,2] == 0
@show permutedims(TA,(2,1))
@show TC = TA+TB
@show add_permute(TA,TB,(2,1))

#
# Test the ITensor class
#

i = Index(2,"i")
j = Index(2,"j")

A = ITensor([1 2; 3 4],i,j)
B = diagITensor([1,2],i,j)

@show A[i(1),j(2)]
@show A[j(2),i(1)]
@show B[i(1),j(1)]
@show B[i(1),j(2)]

@show Ap = permute(A,j,i)

@show A[i(1),j(2)] == Ap[i(1),j(2)]

@show C = A+Ap


