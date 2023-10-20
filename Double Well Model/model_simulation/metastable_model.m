function [error_holder,capacity] = metastable_model(N, p_num, f, threshold, r1, r2, r3, C, sparsity)



init_weight = zeros(N,N);
A=[];
pattern_number = p_num;
for i=1:pattern_number
    A=[A;creat_pattern(N,f)];
end

W = init_weight;
sparse_matrix = ceil(rand(N) - (1-sparsity));
[sparse_W, sparse_index] = code_sparse(W, sparse_matrix);
for i = 1:size(A,1)
    pattern = A(i,:);
    sparse_W = dynamic(sparse_W, sparse_index, pattern, r1, r2, r3, f, C);
end
W = decode_sparse(sparse_W, sparse_index, N);
error_holder = forgetting_curve(W,A,threshold,f);
[~,end_retrieve_num] = cal_retrieve_num(error_holder);
capacity = end_retrieve_num;
