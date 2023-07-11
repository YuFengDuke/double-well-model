function storage_capacity = theoretical_capacity(f, r1, r2, r3, C, c, N)

[init_w, init_pdf, converge] = get_asym_dist(r1, r2, r3, C);
if ~ converge
    storage_capacity = -1;
    return 
end

pattern_num = 500;
[mean_h, std_h] = cal_local_field(init_w, init_pdf, pattern_num, r1, r2, r3, C);

storage_capacity = zeros(size(N));

for j = 1:size(N, 2)
    
    scale_mean_h = mean_h * c * f;
    scale_std_h = sqrt(c*f/N(j)) * std_h;
    
    m = ones(1, size(mean_h,2));
    
    for i = 1: size(mean_h,2)
        m(i) = cal_overlap_from_local_field(scale_mean_h(i), scale_std_h(i), c*f*r2, true);
        if m(i) == 0
            break;
        end
    end
     
    alpha = find(m==0,1);
    if isempty(alpha)
        storage_capacity(j) = pattern_num;
    else
        storage_capacity(j) = alpha - 1; 
    end

end
