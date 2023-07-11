clear;

f = 0.5;
c = 0.05;
r3 = 0;
r2 = 1;

r1_holder = [0.00175, 0.0019, 0.0025, 0.0035, 0.005, 0.0065, 0.0075,0.0079,	0.01, 0.015	0.025, 0.036, 0.05,	0.065, 0.075, 0.077,0.1,0.16,0.25];
C_end = [3, 3,  3,	3, 3, 3, 10, 8, 7, 7, 6.0, 5.72, 5.1, 4.37,	3.9, 3.86, 3.9,	3.5, 3] * 1.2;

R = size(r1_holder,2);
M = 16;

C_holder = zeros(R,M);
for i = 1:R
    C_holder(i,:) = linspace(0,C_end(i),M);
end

N_holder = [20000,30000,40000,60000,80000,100000,200000,300000];

R = size(r1_holder,2);
M = size(C_holder,2);
L = size(N_holder,2);

results.f = f;
results.c = c;
results.r3 = 0;
results.r2 = 1;
results.r1_holder = r1_holder;
results.C_holder = C_holder;
results.N_holder = N_holder;

alphas = zeros(R,M,L);

parpool(16);

for i = 1:R
    r1 = r1_holder(i);
    parfor j = 1:M
        C = C_holder(i,j);
        disp([i,j]);
        alpha = theoretical_capacity(f, r1, r2, r3, C, c, N_holder);
        alphas(i,j,:) = alpha;
    end
    results.alphas = alphas;
    save('result_alpha_CN.mat', 'results');
end

results.alphas = alphas;
save('result_alpha_CN.mat', 'results');
