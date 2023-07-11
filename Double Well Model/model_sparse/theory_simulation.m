function [mean_w, std_w] = theory_simulation(W, sparse_matrix, r1, r2, r3, C) 

N = size(W,2);

p_positive_input = 0.5;

p = 200;

mean_w = zeros(1,p);
std_w = zeros(1,p);

W = reset_diag(W);
[W_t, sparse_index] = code_sparse(W, sparse_matrix);
W_t = W_t + r2;
W_t = multi_state_consolidation_func(W_t,r1,C,1);
for i = 1 : p
    mean_w(i) = mean(W_t);
    std_w(i) = std(W_t);
    pattern = creat_pattern(N, p_positive_input);
    W_t = W_t + r2 * cal_W_delta2(pattern, sparse_index, p_positive_input);
    W_t = multi_state_consolidation_func(W_t,r1,C,1);
    disp(i);
end


% pattern = creat_pattern(N,p_positive_input);
% retrieve_pattern = pattern;
% W_t = W + r2 * (pattern-p_positive_input)'*(pattern-p_positive_input)/p_positive_input/(1-p_positive_input) + r3*randn(size(W));
% for t = T
%     W_delta_t  = multi_state_consolidation_func(W_t,r1,C,b,t);
%     h_t = retrieve_pattern * W_delta_t / N;
%     mean_h = [mean_h, mean(h_t(retrieve_pattern==1))];
%     std_h = [std_h, std(h_t(retrieve_pattern==1))];
% end