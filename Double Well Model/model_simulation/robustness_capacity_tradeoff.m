clear;

N = 10000;
c = 0.05;
threshold = 0;
p_num = 300;
p_positive_input = 0.5;
r2 = 0.5;


r1_holder = [1.75e-3, 2.5e-3, 5e-3, 7.5e-3, 1e-2, 2.5e-2, 5e-2, 7.5e-2, 1e-1, 2.5e-1];
opt_C_holder = [ 0.482, 0.3, 1.286, 1.2, 1.4, 1.343, 1.384, 1.14, 1.135, 0.902];
std_holder = [6.06,	5.06, 4.1,	3.42,	3.18,	2.23,	1.84,	1.48,	1.39,	1];



parpool(16);

r3_holder = 0:0.1:2;
Q = size(r3_holder, 2);
M = size(r1_holder, 2);
P = 10;

all_alpha = zeros(M,Q,P);
s = zeros(size(r1_holder),P);

for k = 1:P
    parfor j = 1 : M
       
        r1 = r1_holder(j);
        C = opt_C_holder(j);
        
        alpha_holder = zeros(size(r3_holder));
        for i = 1 : Q
            r3 = r3_holder(i) * std_holder(j);
            [~, alpha] = metastable_model(N, p_num, p_positive_input, threshold, r1, r2, r3, C * ones(1, 2), c);
            alpha_holder(i) = alpha;
            disp([r3, alpha]);
            if alpha == 0
                break;
            end
        end
        
        all_alpha(j, :, k) = alpha_holder;
        zero_index = find(alpha_holder==0, 1);
        if isempty(zero_index)
            zero_index = size(r3_holder,2);
        end
    
        r = polyfit(r3_holder(1:zero_index),alpha_holder(1:zero_index),1);
        s(j,k) = abs(r(1));
        
    end
    results.s = s;
    results.alpha = all_alpha;
    save('robustness_capacity_tradeoff.mat', 'results');
end

results.s = s;
results.alpha = all_alpha;
save('robustness_capacity_tradeoff.mat', 'results');
