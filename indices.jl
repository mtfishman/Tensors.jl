
# Types to be used as dimensions
struct Index
  dim::Int
  tag::String
end

dim(i::Index) = i.dim
tag(i::Index) = i.tag

Base.:(==)(i1::Index,i2::Index) = (tag(i1) == tag(i2))

struct IndexVal
  ind::Index
  val::Int
end
(i::Index)(n::Int) = IndexVal(i,n)

val(iv::IndexVal) = iv.val
ind(iv::IndexVal) = iv.ind

Base.:(==)(i::Index,iv::IndexVal) = (i==ind(iv))
Base.:(==)(i::IndexVal,iv::Index) = (i==iv)

IndexSet{N} = NTuple{N,Index}

IndexSet(is::Vararg{Index,N}) where {N} = tuple(is)

dims(is::IndexSet{N}) where {N} = ntuple(n -> dim(is[n]),Val(N))

#
# dims must be defined on any type being used
# as indices
#
dims(is::NTuple{N,Int}) where {N} = is

