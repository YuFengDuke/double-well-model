clear;


sparsity = 0.05;
r1 = 0.75;
r2 = 0.5;
r3 = 0;
p_num = 100;
num_state = 2;
f = 0.5;
threshold = 0;

N_holder = [10000, 15000, 20000, 30000, 40000];
C_holder = linspace(0.35,0.65,10);

results.c = sparsity;
results.r1 = r1;
results.r2 = r2;
results.r3 = r3;
results.N_holder = N_holder;
results.C_holder = C_holder;

L = size(N_holder, 2);
M = size(C_holder,2);
alpha = zeros(M,L);

parpool(16);

for i = 1:M
    C = C_holder(i);
    parfor j = 1:L
        [m,capacity] = metastable_model(N_holder(j), p_num, f, threshold, r1, r2, r3, ones(1,num_state) * C, sparsity);
        alpha(i,j) = capacity;
    end
    results.alpha = alpha;
    save('result_sim_deep_limit.mat', 'results');
end

save('result_sim_deep_limit.mat', 'results');