clear;
N=10000;
sparsity = 0.02;
r1 = 2e-1;
r2 = 0.5;
r3 = 0.1;
num_state = 2;


C = ones(1,num_state) * 1;
b = ones(1, num_state);
theta = 0;
threshold = theta*N*r2;


mean_h_holder = [];
std_h_holder = [];
for iter = 1:10
    
    p_positive_input = 0.5;
    init_weight = zeros(N,N);
    A=[];
    pattern_number = 500;
    disp(pattern_number/N);
    for i=1:pattern_number
        A=[A;creat_pattern(N,p_positive_input)];
    end

    W = init_weight;
    sparse_matrix = ceil(rand(N) - (1-sparsity));
    [sparse_W, sparse_index] = code_sparse(W, sparse_matrix);
    for i = 1:size(A,1)
        pattern = A(i,:);
        sparse_W = dynamic(sparse_W, sparse_index, pattern, r1, r2, r3, p_positive_input, C, b);
    end
    
    W = decode_sparse(sparse_W, sparse_index, N);
    [mean_h, std_h] = theory_simulation(W, sparse_matrix, r1, r2, r3, C, b);
    mean_h_holder = [mean_h_holder; mean_h];
    std_h_holder = [std_h_holder; std_h];
end


hold on;
errorbar(mean(std_h_holder), std(std_h_holder),'s');