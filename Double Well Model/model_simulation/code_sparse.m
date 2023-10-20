function [sparse_W, sparse_index] = code_sparse(W, sparse_matrix)

[i,j,s] = find(sparse_matrix);
sparse_index = [i,j];
sparse_W = zeros(size(s));
for k = 1:size(s,1)
    sparse_W(k) = W(sparse_index(k,1), sparse_index(k,2));
end
