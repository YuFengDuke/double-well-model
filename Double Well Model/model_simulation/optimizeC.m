function [optim_C, max_capacity, optim_error] = optimizeC(N, p_num, p_positive_input, threshold, r1, r2, r3, sparsity)

C_holder = linspace(0, 2, 20);
num_state = 2;
max_capacity = 0;
optim_C = 0;
optim_error = [];
for C = C_holder
    [error_holder,capacity] = metastable_model(N, p_num, p_positive_input, threshold, r1, r2, r3, ones(1,num_state) * C, sparsity);
    disp([C, capacity]);
    if capacity > max_capacity
        max_capacity = capacity;
        optim_error = error_holder;
        optim_C = C;
    end
end