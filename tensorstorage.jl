
abstract type TensorStorage end

data(T::TensorStorage) = T.data

Base.copy(T::StorageT) where {StorageT<:TensorStorage} = StorageT(copy(T.data))

Base.getindex(D::TensorStorage,n::Integer) = data(D)[n]

