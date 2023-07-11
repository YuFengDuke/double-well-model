% clear;

%42.4000   47.6000   52.8000   59.6000   64.6000  73,       82
%39.0000   46.0000   52.0000   58.0000   64.0000  73.0000   81.0000
load('result_sim.mat');



f = 0.5;
r1 = 0.1;
r2 = 1;
r3 = 0;
C = 2.7;
c = 0.05;
N = 20000;

range_x = get_range_x(r1) * 2;
init_w = linspace(-range_x,range_x,4000);
init_pdf = randn(size(init_w));

for i = 1:10000
    [iter_pdf, error] = recursion_relation(init_w, init_pdf, r1, r2, r3, C);
    init_pdf = iter_pdf;
    if error < 1e-4
        break;
    end
    disp([error]);
end

pattern_num = 200;
[mean_h, std_h] = cal_local_field(init_w, init_pdf, pattern_num, r1, r2, r3, C);

mean_h = mean_h * c * f;
std_h = sqrt(c*f/N) * std_h;

m = zeros(1, size(mean_h,2));
for i = 1: size(mean_h,2)
    m(i) = cal_overlap_from_local_field(mean_h(i), std_h(i), c*f*r2, true);
    disp([i,m(i)]);
    if m(i) == 0
        break;
    end
end

figure;
plot(m,'LineWidth',2);
% hold on;
% mean_m = squeeze(results.mean_m(r1_index,N_index,:));
% std_m = squeeze(results.std_m(r1_index,N_index,:));
% errorbar(mean_m(end:-1:1),std_m(end:-1:1),'s');
xlabel('$t$','Interpreter','latex');
ylabel('$m$','Interpreter','latex');
set(gca,'FontSize',28);