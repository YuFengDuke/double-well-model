%define paras
f = 0.5; % coding level
r1 = 0.1; % decay rate
r2 = 1; % input scaling
r3 = 0; % noise strengh
C = 2.7; % double well potentil width
c = 0.05; % sparsity 
N = 10000; % network size

%define range for soloving pdf
range_x = get_range_x(r1) * 2;
init_w = linspace(-range_x,range_x,4000);
init_pdf = randn(size(init_w));

%solve for steady distribution for master equation
for i = 1:10000
    [iter_pdf, error] = recursion_relation(init_w, init_pdf, r1, r2, r3, C);
    init_pdf = iter_pdf;
    if error < 1e-4
        break;
    end

    if mod(i, 50) ==0
        disp(["the diff between two iter is ", num2str(error)]);
    end
end

% calculate local field based on pdf of weight
pattern_num = 100;
[mean_h, std_h] = cal_local_field(init_w, init_pdf, pattern_num, r1, r2, r3, C);

%scale the local field with sparsity, network size and coding level
mean_h = mean_h * c * f;
std_h = sqrt(c*f/N) * std_h;

%get the fixed point for neuronal dynamic
m = zeros(1, size(mean_h,2));
for i = 1: size(mean_h,2)
    m(i) = cal_overlap_from_local_field(mean_h(i), std_h(i), c*f*r2, true);
    disp([num2str(i), " th pattern overlap is ", num2str(m(i))]);
    if m(i) == 0
        break;
    end
end

%plot the steady distribution for master equation
figure;
plot(init_w,init_pdf,'LineWidth',2);
xlabel('$w$','Interpreter','latex');
ylabel('$pdf$','Interpreter','latex');
set(gca,'FontSize',28);

%plot retrival quailty vs memory age
figure;
plot(m,'LineWidth',2);
xlabel('$t$','Interpreter','latex');
ylabel('$m$','Interpreter','latex');
set(gca,'FontSize',28);