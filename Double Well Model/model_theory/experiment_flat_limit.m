clear;

f = 0.5;
r2 = 0.5;
r3 = 0;
c = 0.05;

r1_holder = [1.75e-3];
base_C_holder = [0.5];

N_holder = [10000, 15000, 20000, 30000, 40000];

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
        C_holder = linspace(base_C * 0.1, base_C * 3, L);
        C(k,:) = C_holder;
        for i = 1:M
            [opt_C, opt_alpha, alpha_holder] = get_optimal_C(C_holder, f, r1, r2, r3, c, N_holder(i));
            alpha(i,:, k, p) = alpha_holder;
            disp([N_holder(i),r1_holder(k)]);
        end
        results.C = C;
        results.alpha = alpha;
        save('result_flat_limit.mat', 'results');
    end
end

results.C = C;
results.alpha = alpha;
save('result_flat_limit.mat', 'results');
