function [opt_C, opt_target, target_holder] = get_optimal_C(C_holder, f, r1, r2, r3, c, N)


storage_capacity_holder = zeros(size(C_holder));
K = size(C_holder,2);
parfor i = 1 : K
    C = C_holder(i);
    storage_capacity = theoretical_capacity(f, r1, r2, r3, C, c, N);
    disp([C, storage_capacity]);
    storage_capacity_holder(i) = storage_capacity;
end
[max_capacity, max_arg] = max(storage_capacity_holder);
opt_C = C_holder(max_arg);
opt_target = max_capacity;
target_holder = storage_capacity_holder;


% if strcmp(target, 'slope')
%     func = fittype('a*x^b','coeff',{'a','b'});
%     N_holder = [2500, 5000,7500, 10000, 12500, 15000, 17500, 20000];
%     opt_C = 0;
%     slope_holder = zeros(size(C_holder));
%     opt_slope = -1;
%     for i = 1 : size(C_holder,2)
%         C = C_holder(i);
%         storage_capacity = theoretical_capacity(f, r1, r2, r3, C, c, N_holder);
%         if storage_capacity == -1
%             break;
%         end
%         paras.b = -1;
%         while paras.b < 0
%             paras = fit(N_holder',storage_capacity',func);
%         end
%         slope = paras.b;
%         slope_holder(i) = slope;
%         if slope > opt_slope
%             opt_C = C;
%             opt_slope = slope;
%         end
%     end
%     opt_target = opt_slope;
%     target_holder = slope_holder;
% end