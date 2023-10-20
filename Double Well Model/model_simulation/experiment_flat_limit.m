clear;


sparsity = 0.05;
r1 = 0.001;
r2 = 1;
r3 = 0;
p_num = 500;
num_state = 2;
f = 0.5;
threshold = 0;

N_holder = [20000, 30000, 40000, 50000];
C = 0;

results.c = sparsity;
results.r1 = r1;
results.r2 = r2;
results.r3 = r3;
results.N_holder = N_holder;

L = size(N_holder, 2);
alpha = zeros(L,1);
ms = zeros(L, p_num);

for i = 1:L
    [m,capacity] = metastable_model(N_holder(i), p_num, f, threshold, r1, r2, r3, ones(1,num_state) * C, sparsity);
    alpha(i) = capacity;
    ms(i,:) = m;
    results.alpha = alpha;
    results.ms = ms;
    save('result_sim_flat_limit.mat', 'results');
end

results.alpha = alpha;
results.ms = ms;
save('result_sim_flat_limit.mat', 'results');
