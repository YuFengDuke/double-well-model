function W = decode_sparse(sparse_W, sparse_index, N)

W = zeros(N);

for k = 1: size(sparse_index, 1)
    W(sparse_index(k,1),sparse_index(k,2)) = sparse_W(k);
end
