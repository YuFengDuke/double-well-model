function W_delta_2 = cal_W_delta2(pattern, sparse_index, p_positive_input)

a = p_positive_input;
W_delta_2 = zeros(size(sparse_index,1),1);


for k = 1:size(sparse_index, 1)
    W_delta_2(k) = (pattern(sparse_index(k,1))-a) *  (pattern(sparse_index(k,2))-a) / a / (1-a);
end