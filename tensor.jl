
# A dumb tensor (no assumption of labels)
struct Tensor{StoreT,IndsT}
  store::StoreT
  inds::IndsT
end

store(T::Tensor) = T.store
inds(T::Tensor) = T.inds

# The size is obtained from the indices
function Base.size(T::Tensor{StoreT,IndsT}) where {StoreT,IndsT}
  return dims(inds(T))
end

Base.copy(T::Tensor) = Tensor(copy(store(T)),inds(T))

