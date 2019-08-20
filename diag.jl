
struct Diag <: TensorStorage
  data::Vector{Float64}
end

Base.:+(D1::Diag,D2::Diag) = Dense(data(D1)+data(D2))

#
# Diag Tensor functions
#

function Base.getindex(T::Tensor{<:Diag}, inds::Int...)
  if all(==(inds[1]),inds)
    return store(T)[inds[1]]
  else
    return zero(Float64)
  end
end

function Base.setindex!(T::Tensor{<:Diag}, val, inds::Int...)
  if all(==(inds[1]),inds)
    return store(T)[inds[1]] = val
  else
    error("Cannot set off-diagonal elements")
  end
end

function Base.permutedims(T::Tensor{<:Diag},perm)
  Tp_store = copy(store(T))
  Tp_inds = genperm(inds(T),perm)
  return Tensor(Tp_store,Tp_inds)
end

# Add two Diag Tensors with no permutation of indices
function Base.:+(A::Tensor{<:Diag},B::Tensor{<:Diag})
  return Tensor(store(A)+store(B),inds(A))
end

# Add two Diag Tensors with no permutation of indices
function Base.:+(A::Tensor{<:Dense,NTuple{N,IndT}},B::Tensor{<:Diag,NTuple{N,IndT}}) where {N,IndT}
  C = copy(A)
  mindim = minimum(size(A))
  for i = 1:mindim
    C[ntuple(_->i,Val(N))...] += B[i]
  end
  return C
end

Base.:+(A::Tensor{<:Diag},B::Tensor{<:Dense}) = B+A

# Add Tensor A to B while permuting B by perm
function add_permute(A::Tensor{<:Diag},B::Tensor{<:Diag},perm)
  return A+B
end

function add_permute(A::Tensor{<:Dense},B::Tensor{<:Diag},perm)
  return A+B
end

add_permute(A::Tensor{<:Diag},B::Tensor{<:Dense},perm) = add_permute(B,A,perm)

