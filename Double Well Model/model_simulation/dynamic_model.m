% clear;
N = 10000;
sparsity = 0.05;
r1 = 5e-2;
r2 = 0.5;
r3 = 0;
num_state = 2;
C = ones(1,num_state) * 1.35;
b = ones(1, num_state);

% b = [1,1];
% b = C(1) ./ C.^2;
% C = 0.46 * ones(1,num_state);
% b = ones(1,num_state);
theta = 0;
threshold = theta*N*r2;


p_positive_input = 0.5;

init_weight = zeros(N,N);
A=[];
pattern_number = 100;
disp(pattern_number/N);
for i=1:pattern_number
    A=[A;creat_pattern(N,p_positive_input)];
end

W = init_weight;
error_holder = [];
history_weight = [];
r2_holder = [];

sparse_matrix = ceil(rand(N) - (1-sparsity));
[sparse_W, sparse_index] = code_sparse(W, sparse_matrix);

tic;
for i = 1:size(A,1)
    pattern = A(i,:);
    sparse_W = dynamic(sparse_W,sparse_index,pattern,r1,r2,r3,p_positive_input,C);
    disp([i]);
end
toc;

W = decode_sparse(sparse_W, sparse_index, N);

% pattern = creat_pattern(N,p_positive_input);
% % W_t = W + r2 * (pattern-p_positive_input)'*(pattern-p_positive_input)/p_positive_input/(1-p_positive_input) + r3*randn(size(W));
% % pattern = ones(1,N);
% W_t = W + r2 +  r3*randn(size(W));
% W_t  = multi_state_consolidation_func(W_t,r1,C,b,1);
% W_t = W_t + r2 * (pattern-p_positive_input)'*(pattern-p_positive_input)/p_positive_input/(1-p_positive_input) + r3*randn(size(W));
% 
% h_t = pattern * W_t / N;
% mean(h_t(pattern == 1))

% figure;
% histogram(h_t, 100, 'Normalization','pdf');plot(init_w,iter_pdf)
% xlabel('$h_t$','Interpreter','latex','FontSize',18);
% ylabel('$pdf$','Interpreter','latex','FontSize',18);
% set(gca,'FontSize',32);


% figure;
% histogram(reshape(W_t,1,N*N),200,'Normalization','pdf');
% hold on;
% plot_potential_well(C,b);
% xlabel('$J_{ij}$','Interpreter','latex','FontSize',18);
% ylabel('$pdf$','Interpreter','latex','FontSize',18);
% set(gca,'FontSize',32);



figure;
pattern = A(end-30,:);
fix_point = hopfield_test(W,pattern,0);
signal_sum(pattern,fix_point,p_positive_input);
h = fix_point * W / N;
histogram(h((pattern==1)), 50, 'Normalization','pdf');
xlabel('$h_i$','Interpreter','latex','FontSize',18);
ylabel('$N$','Interpreter','latex','FontSize',18);
set(gca,'FontSize',32);


figure;
histogram(sparse_W,100,'Normalization','pdf');
% histogram(reshape(W,1,N*N),100);
hold on;
plot_potential_well(C,0);
plot(C(1) * (1 - exp(-2*r1)), 0, 'ko','MarkerSize',8,'MarkerFaceColor','k');
plot(r2, 0, 'ro','MarkerSize',8,'MarkerFaceColor','r')
xlabel('$J_{ij}$','Interpreter','latex','FontSize',18);
ylabel('$pdf$','Interpreter','latex','FontSize',18);
set(gca,'FontSize',32);


% 
% W = reset_diag(W);
figure;
errors = forgetting_curve(W,A,threshold,p_positive_input);
plot(errors,'s','LineWidth',2,'MarkerSize',10);
xlabel('$t$','Interpreter','latex','FontSize',18);
ylabel('$m$','Interpreter','latex','FontSize',18);
set(gca,'FontSize',24);
[begin_retrieve_num,end_retrieve_num] = cal_retrieve_num(errors);
disp([begin_retrieve_num,end_retrieve_num]);
disp(size(find(errors>0.1),2));




% l = 13;
% f = p_positive_input;
% test_pattern = A(end-l,:); 
% input = test_pattern;
% 
% 
% input = local_field_dynamic(W, input);
% r_m = signal_sum(test_pattern,input,f);
% h = input * W / N;
% h_p = h(test_pattern==1);
% mis_percentage = size(h_p(h_p<0),2) / size(h_p, 2);
% e_m = 1 - 2* mis_percentage;
% disp([r_m, e_m]);
% 
% 
% figure;
% histogram(h_p,100,'Normalization','pdf');
% hold on;
% plot_normal_dist(e_m * mean_h(l+1), sqrt((1+e_m^2)/2) * std_h(l+1));
% xlabel('$h_i$','Interpreter','latex','FontSize',18);
% ylabel('$pdf$','Interpreter','latex','FontSize',18);
% set(gca,'FontSize',24);



% num_state = size(C,2);
% [M_p,M_n] = cal_markov_matrix(pattern,W_before,W_after,p_positive_input,C,num_state);
% disp(M_p);
% disp(M_n);
% 
% H = history_weight;
% spine_index = find(H(1,:)==1);
% survive_pro1 = survive_count(H(1:end,:),spine_index,1);
% % spine_index = find(H(1,:)==2);
% % survive_pro2 = survive_count(H(1:end,:),spine_index,1);
% spine_index = find(H(1,:)>0);
% survive_pro3 = survive_count(H(1:end,:),spine_index,1);
% 
% figure;
% loglog(survive_pro1,'LineWidth',2,'DisplayName','$state=1$');
% hold on;
% loglog(survive_pro3,'LineWidth',2,'DisplayName','$state>0$');
% l=legend();
% l.set('Interpreter','latex');
% xlabel('$t$','Interpreter','latex');
% ylabel('$SP$','Interpreter','latex');
% set(gca,'FontSize',24);

% plot(linspace(0,6,size(survive_pro1,2)),survive_pro1)