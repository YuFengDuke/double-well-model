clear;

f = 0.5;
r2 = 0.5;
r3 = 0;
c = 0.05;


r1_holder = [7.5e-4, 1e-3, 2.5e-3, 5e-3, 7.5e-3, 1e-2, 2.5e-2, 5e-2, 7.5e-2, 1e-1, 2.5e-1, 5e-1, 7.5e-1];
L = size(r1_holder,2);
N_holder = [5000, 7500, 10000, 12500, 15000, 17500, 20000, 25000, 30000] * 6;
%r1_holder = [7.5e-4, 1e-3, 2.5e-3, 5e-3, 7.5e-3, 1e-2, 2.5e-2, 5e-2, 7.5e-2, 1e-1, 2.5e-1, 5e-1, 7.5e-1, 1];
% opt_C_holder = zeros(size(r1_holder));
% C_holder = linspace(0,1.5,16);
% parfor i = 1:L
%     r1 = r1_holder(i);
%     [opt_C, opt_target, target_holder] = get_optimal_C(C_holder, f, r1, r2, r3, c, 50000, 'C');
%     opt_C_holder(i) = opt_C; 
%     disp([r1, opt_C, opt_target]);
% end

opt_C_holder = [0.6,0.6,0.6,0.6,1.275, 1.275, 1.45, 1.41, 1.26, 1.15,  0.9368,  0.7368, 0.63];

P = 1;
storage_capacity = zeros(size(r1_holder,2), size(N_holder,2), P);
for k = 1:P
    parfor i = 1:L
        r1 = r1_holder(i);
        C = opt_C_holder(i);
        capacity = theoretical_capacity(f, r1, r2, r3, C, c, N_holder);
        storage_capacity(i,:,k) = capacity;
        disp([r1,capacity]);
    end
end

func = fittype('a*x^b','coeff',{'a','b'});
slope = zeros(L, 1);

for k = 1:P
    for i = 1:L
        paras.b = -1;
        while paras.b < 0
            paras = fit(N_holder(1:end)',storage_capacity(i,1:end,k)',func);
        end
        slope(i, k) = paras.b;
    end
end


for k = 1:P
    for i = 1:L
        paras = polyfit(log(N_holder), log(storage_capacity(i,:,k)),1);
        slope(i, k) = paras(1);
    end
end


results.f = f;
results.sparsity = c;
results.r1_holder = r1_holder;
results.N_holder = N_holder;
results.optim_C = opt_C_holder;
results.capacity = storage_capacity;
results.slope = slope;
%save('theory_result_2state_f05.mat', 'results');

semilogx(r1_holder, slope);
load('result_2state_f05.mat');
hold on;
errorbar(results.r1_holder(1:end), results.mean_slope(1:end), results.std_slope(1:end),  's');