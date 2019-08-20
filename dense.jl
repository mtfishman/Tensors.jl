
struct Dense <: TensorStorage
  data::Vector{Float64}
  Dense(A::Array) = new(vec(A))
end

data(D::Dense) = D.data

Base.:+(D1::Dense,D2::Dense) = Dense(data(D1)+data(D2))

#
# Dense Tensor functions
#

# Indexing into a Dense Tensor uses the size function
function Base.getindex(T::Tensor{<:Dense}, inds::Int...)
  return reshape(data(store(T)),size(T))[inds...]
end

function Base.setindex!(T::Tensor{<:Dense}, val, inds::Int...)
  return reshape(data(store(T)),size(T))[inds...] = val
end

function Base.permutedims(T::Tensor{<:Dense},perm)
  Tp_store = Dense(vec(permutedims(reshape(data(store(T)),size(T)),perm)))
  Tp_inds = genperm(inds(T),perm)  
  return Tensor(Tp_store,Tp_inds)
end

# Add two Dense Tensors with no permutation of indices
function Base.:+(A::Tensor{<:Dense},B::Tensor{<:Dense})
  return Tensor(store(A)+store(B),inds(A))
end

# Add Tensor A to B while permuting B by perm
function add_permute(A::Tensor{<:Dense},B::Tensor{<:Dense},perm)
  # This would be implemented with a single function
  # that permutes and adds at the same time
  if !is_trivial_permutation(perm)
    B = permutedims(B,perm)
  end
  return A+B
end

