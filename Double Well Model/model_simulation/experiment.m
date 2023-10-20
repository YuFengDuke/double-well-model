clear;
load('optim_C.mat');
r1_holder = [1.75e-3, 2.5e-3, 5e-3, 7.5e-3, 1e-2, 2.5e-2, 5e-2, 7.5e-2, 1e-1, 2.5e-1];
N_holder = [10000, 12500, 15000, 17500, 20000, 25000, 30000];
L = size(r1_holder, 2);
M = size(N_holder, 2);
P = 10;

optim_C_holder = theory_C;
capacity_mat = zeros(L,M,P);
m_holder = cell(L, M, P);

r2 = 0.5;
r3 = 0;
sparsity = 0.05;
num_state = 2;
threshold = 0;
p_positive_input = 0.5;
p_num = 300;


results.r1_holder = r1_holder;
results.N_holder = N_holder;
results.sparsity = sparsity;
results.f = p_positive_input;
results.optim_C = optim_C_holder;

parpool(16);

for iter = 1:P
    for i = 1:L
        r1 = r1_holder(i);
        parfor j = 1:M
            optim_C = optim_C_holder(i, j);
            N = N_holder(j);
            [m,capacity] = metastable_model(N, p_num, p_positive_input, threshold, r1, r2, r3, ones(1,num_state) * optim_C, sparsity);
            capacity_mat(i,j, iter) = capacity;
            m_holder{i, j, iter} = m;
            disp([i,j,capacity]);
        end
        results.alpha = capacity_mat;
        results.m_holder = m_holder;
        save('result_sim.mat', 'results');
    end
end

results.alpha = capacity_mat;
results.m_holder = m_holder;
save('result_sim.mat', 'results');