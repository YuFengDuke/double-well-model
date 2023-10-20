function W_after = dynamic(W_before,sparse_index, pattern,r1,r2,r3,positive_input,C)

% N = size(W_before,2);


W_delta_2 = cal_W_delta2(pattern, sparse_index, positive_input);
% W_delta_2 =  (pattern-a)'*(pattern-a)/a/(1-a);
% W_delta_2 = code_sparse(W_delta_2, sparse_matrix);

W_learned = W_before + r2*W_delta_2 + r3*randn(size(W_before));

% W_learned = min(W_learned, sum(C) * ones(size(W_learned)));

% matrix_func = @(W) consolidation_func(W,r1,C);
% W_after = arrayfun(matrix_func,W_learned);



% W_after = consolidation_func(W_learned,r1,C);

W_after = multi_state_consolidation_func(W_learned,r1,C);