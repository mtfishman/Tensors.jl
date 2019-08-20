include("permutations.jl")
include("tensor.jl")
include("tensorstorage.jl")
include("dense.jl")
include("diag.jl")
include("indices.jl")

# A smart tensor (dimensions have labels)
struct ITensor{N}
  store::TensorStorage
  inds::IndexSet{N}
end

store(A::ITensor) = A.store
inds(A::ITensor) = A.inds

# Convenience function for making a Tensor out
# of an ITensor and vice versa
Tensor(A::ITensor) = Tensor(store(A),inds(A))
ITensor(A::Tensor{_,IndsT}) where {_,IndsT<:IndexSet} = ITensor(store(A),inds(A))

ITensor(d::Array{T,N},is::Vararg{Index,N}) where {T,N} = ITensor(Dense(vec(d)),IndexSet(is))
diagITensor(d::Vector{T},is::Vararg{Index,N}) where {T,N} = ITensor(Diag(d),IndexSet(is))

#
# ITensor functions
#

# Indexing an ITensor calls indexing a Tensor
function Base.getindex(A::ITensor{N},ivs::Vararg{IndexVal,N}) where {N}
  vals = ntuple(n->val(ivs[n]),Val(N))
  p = calculate_permutation(inds(A),ivs)  
  return Tensor(A)[vals[p]...]
end

function permute(A::ITensor{N},is::Vararg{Index,N}) where {N}
  p = calculate_permutation(inds(A),is)
  return ITensor(permutedims(Tensor(A),p))
end

function Base.:+(A::ITensor{N},B::ITensor{N}) where {N}
  p = calculate_permutation(inds(A),inds(B)) 
  return ITensor(add_permute(Tensor(A),Tensor(B),p))
end

