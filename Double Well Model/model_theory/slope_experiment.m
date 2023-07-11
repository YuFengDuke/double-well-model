clear;

f = 0.5;
r2 = 0.5;
r3 = 0;
c = 0.05;

r1_holder = [1.75e-3, 2.5e-3, 5e-3, 7.5e-3, 1e-2, 2.5e-2, 5e-2, 7.5e-2, 1e-1, 2.5e-1];
base_C_holder = [0.3, 0.3, 1.2, 2.2, 2, 2, 1.7, 1.3, 1.3, 1];

r1_holder = interp(r1_holder, 2);
base_C_holder = interp(base_C_holder, 2);

N_holder = [10000, 12500, 15000, 17500, 20000, 25000, 30000, 35000, 40000, 80000];

M = size(N_holder,2);
L = 12;
K = size(r1_holder, 2);
P = 5;

alpha = zeros(M, L, K, P);
C = zeros(K, L);

results.f = f;
results.sparsity = c;
results.r1_holder = r1_holder;
results.N_holder = N_holder;

parpool(16);

for p = 1:P
    for k = 1:K
        r1 = r1_holder(k);
        base_C = base_C_holder(k);
        C_holder = linspace(base_C * 0.5, base_C * 1.5, L);
        C(k,:) = C_holder;
        for i = 1:M
            [opt_C, opt_alpha, alpha_holder] = get_optimal_C(C_holder, f, r1, r2, r3, c, N_holder(i));
            alpha(i,:, k, p) = alpha_holder;
            disp([N_holder(i),r1_holder(k)]);
        end
        results.C = C;
        results.alpha = alpha;
        save('result_theory.mat', 'results');
    end
end

results.C = C;
results.alpha = alpha;
save('result_theory.mat', 'results');
