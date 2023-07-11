clear;
r1_holder = [7.5e-4, 1e-3, 2.5e-3, 5e-3, 7.5e-3, 1e-2, 2.5e-2, 5e-2, 7.5e-2, 1e-1, 2.5e-1, 5e-1, 7.5e-1, 1];
opt_C_holder = [0.6, 0.6, 0.6, 0.6, 1.275, 1.275, 1.45, 1.41, 1.26, 1.15,  0.9368,  0.7368, 0.6315,0.526];


f = 0.5;
r2 = 0.5;
r3 = 0;
c = 0.05;
threshold = 0;
N = 40000;
p_num = 500;
num_state = 2;

L = size(r1_holder, 2);
P = 1;
m_hodler = {};

parpool(16);
parfor i = 1:L
    r1 = r1_holder(i);
    optim_C = opt_C_holder(i);
    [error, ~] = metastable_model(N, p_num, f, threshold, r1, r2, r3, ones(1,num_state) * optim_C, c);
    m_hodler{i} = error;
    disp(i);
end

results.f = f;
results.sparsity = c;
results.r1_holder = r1_holder;
results.N_holder = N;
results.optim_C = opt_C_holder;
results.m = m_hodler;

save('result_overlap_2state_f05_N40000.mat', 'results');
