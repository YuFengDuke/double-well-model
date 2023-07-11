function m = cal_overlap_from_local_field(mean_h, std_h, r2, type)


if type == false
    prev_m = 1;

    tolerance = 0;
    count = 0;
    MAX_ITER = 10000;
    for i = 1: MAX_ITER
        m = local_field_recursion(prev_m, mean_h, std_h);
        if abs(m - prev_m) == tolerance
            count = count + 1;
        end
        if count > 500
            break;
        end
        prev_m = m;
    end
end

if type == true
    
    prev_mt = 1;
    prev_m1 = 5e-4;
    
    tolerance = 0;
    count = 0;
    MAX_ITER = 10000;
    for i = 1: MAX_ITER
        [mt, m1] = chaotic_local_field_recursion(prev_mt, prev_m1, mean_h, std_h, r2);
        if abs(mt - prev_mt) == tolerance
            count = count + 1;
        end
        if count > 500
            break;
        end
        prev_mt = mt;
        prev_m1 = m1;
    end
    
    m = mt;
end
