
#
# General permutation helper functions
#

function calculate_permutation(set1, set2)
  l1 = length(set1)
  l2 = length(set2)
  l1==l2 || throw(DimensionMismatch("Mismatched input sizes in calcPerm: l1=$l1, l2=$l2"))
  p = zeros(Int,l1)
  for i1 = 1:l1
    for i2 = 1:l2
      if set1[i1]==set2[i2]
        p[i1] = i2
        break
      end
    end #i2
    p[i1]!=0 || error("Sets aren't permutations of each other")
  end #i1
  return p
end

function is_trivial_permutation(p)
  for n = 1:length(p)
    p[n]!=n && return false
  end
  return true
end

genperm(I::NTuple{N,Any}, perm) where {N} = ntuple(d -> I[perm[d]], Val(N))

