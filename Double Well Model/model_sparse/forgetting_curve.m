function error = forgetting_curve(W,A,threshold,p_positive_input)
W = reset_diag(W);
p = size(A, 1);
step = 1;
error = zeros(1, p);
count = 0;
for i = size(A,1) : -step : 1
    test_pattern=A(i,:);
    fix_point=hopfield_test(W,test_pattern,threshold);
    
    %%%
%     h = fix_point * W;
%     h_p = h(test_pattern==1);
%     mis_percentage = size(h_p(h_p<0),2) / size(h_p, 2);
%     m = 1 - 2* mis_percentage;
%     m_s = [m_s,m];
    %%%
    
    error(i) = signal_sum(test_pattern,fix_point,p_positive_input);
    disp([i, error(i)]);
    if error(i) < 0.1
        count = count + 1;
    end
    if count > 5
        break;
    end
end
% 
% error = error(end:-1:1);
