clear;

sparsity = 0.05;
r1 = 1;
r2 = 0.5;
r3 = 0;
p_num = 100;
num_state = 2;
f = 0.5;
threshold = 0;
C = 0.577895;

N_holder = [10000, 15000, 20000, 30000, 40000];
L = size(N_holder, 2);
P = 5;

parpool(16);

alpha = zeros(L, P);
for i = 1:P
    parfor j = 1:L
        [m,capacity] = metastable_model(N_holder(j), p_num, f, threshold, r1, r2, r3, ones(1,num_state) * C, sparsity);
        alpha(j,i) = capacity;
    end
    results.alpha = alpha;
    save('result_sim_deep.mat', 'results');
end

results.N_holder = N_holder;
slopes = [];
for i = [1,2,5]
    slope = polyfit(log(N_holder)', log(results.alpha(:,i)), 1);
    slopes = [slopes,slope(1)];
end

results.slopes = slopes;
results.mean_slope = mean(slopes);
results.std_slope = std(slopes);
save('result_sim_deep.mat', 'results');