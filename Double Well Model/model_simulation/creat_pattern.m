function pattern = creat_pattern(N,p_positive_input)

M_p =  round(N*p_positive_input);
M_n = N-M_p;

L = [ones(1,M_p),zeros(1,M_n)];

seed = randperm(N);
pattern = L(seed);