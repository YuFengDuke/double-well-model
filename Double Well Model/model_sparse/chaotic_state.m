function retrieve_pattern = chaotic_state(W, patterns)

p = size(patterns, 1);
retrieve_pattern = zeros(1, p);
for i = 1 : p
    fix_point = hopfield_test(W, patterns(i,:), 0);
    disp(i);
    tmp = zeros(1,p);
    for j = 1 : p
        m = signal_sum(patterns(j,:), fix_point, 0.5);
        tmp(j) = abs(m);
    end
    [~, max_arg] = max(tmp);
    retrieve_pattern(i) = max_arg;
end