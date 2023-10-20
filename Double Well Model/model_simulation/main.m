clear;
%define paras
N = 10000;% network size
sparsity = 0.05;% sparsity
f = 0.5; % coding level
r1 = 0.1; % decay rate
r2 = 1; % input scaling
r3 = 0; % noise strength
num_state = 2; % number of state, double well potential when num_state==2
C = ones(1,num_state) * 2.7; % potential width

theta = 0; % neuronal activity threshold
threshold = theta*N*r2;

% generate independent patterns
init_weight = zeros(N,N);
A=[];
pattern_number = 100;
disp(pattern_number/N);
for i=1:pattern_number
    A=[A;creat_pattern(N,f)];
end

W = init_weight;

%use sparse version of W to speed up simulation
sparse_matrix = ceil(rand(N) - (1-sparsity));
[sparse_W, sparse_index] = code_sparse(W, sparse_matrix);

%learn patterns
tic;
for i = 1:size(A,1)
    pattern = A(i,:);
    sparse_W = dynamic(sparse_W,sparse_index,pattern,r1,r2,r3,f,C);
    disp(['learning pattern ', num2str(i)]);
end
toc;

W = decode_sparse(sparse_W, sparse_index, N);

%plot distribution of weight
figure;
histogram(sparse_W,100,'Normalization','pdf');
hold on;
%plot_potential_well(C,0);
xlabel('$J_{ij}$','Interpreter','latex','FontSize',18);
ylabel('$pdf$','Interpreter','latex','FontSize',18);
set(gca,'FontSize',32);

%plot retrival quality
figure;
errors = forgetting_curve(W,A,threshold,f);
plot(errors,'s','LineWidth',2,'MarkerSize',10);
xlabel('$t$','Interpreter','latex','FontSize',18);
ylabel('$m$','Interpreter','latex','FontSize',18);
set(gca,'FontSize',24);
