clear;

r1_holder = [7.5e-3, 1e-2, 2.5e-2, 5e-2, 7.5e-2, 1e-1, 2.5e-1, 5e-1, 7.5e-1, 1];
opt_C_holder = [0,0,0.7,1.2,1.2,1,0.9,0.6,0.4,0];

f = 0.5;
r2 = 0.5;
r3 = 0;
N = 10000;
c = 0.05;

M = size(r1_holder, 2);

std_holder = zeros(size(M));
for i = 1 : M
    r1 =r1_holder(i);
    C = opt_C_holder(i);
    [init_w, init_pdf] = get_asym_dist(r1, r2, r3, C);
    mean_dist = trapz(init_w, init_w .* init_pdf);
    std_dist = sqrt((trapz(init_w, init_w.^2 .* init_pdf) - mean_dist^2));
    std_holder(i) = std_dist;
end

r3_holder = 0:0.05:0.5;
Q = size(r3_holder, 2);

r1 = r1_holder(3);
C = opt_C_holder(3);
alpha_holder = zeros(size(r3_holder));
for i = 1: Q
    r3 = r3_holder(i) * std_holder(3);
    alpha = theoretical_capacity(f, r1, r2, r3, C, c, N);
    alpha_holder(i) = alpha;
    disp([r3, alpha]);
end