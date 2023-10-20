function overlap = forgetting_curve(W,A,threshold,p_positive_input)
W = reset_diag(W);
p = size(A, 1);
step = 1;
overlap = zeros(1, p);
count = 0;
for i = size(A,1) : -step : 1
    test_pattern=A(i,:);
    fix_point=hopfield_test(W,test_pattern,threshold);
    
    overlap(i) = signal_sum(test_pattern,fix_point,p_positive_input);
    disp([num2str(i), " th pattern overlap is ", num2str(overlap(i))]);
    if overlap(i) < 0.1
        count = count + 1;
    end
    if count > 5
        break;
    end
end

