clear;
load('result_sim.mat');

X = size(results.m_holder{1}, 2);
P = size(results.m_holder,3);
M = size(results.m_holder,2);
L = size(results.m_holder, 1);

P = 5;
% r1 * N * time * P
results.m = zeros(L, M, X, P);
for i = 1 : L
    for j = 1:M
        for k = 1 : P
            results.m(i,j,:,k) = results.m_holder{i,j,k};
        end
    end
end

results.mean_m = mean(results.m, 4);
results.std_m = std(results.m, 0, 4);

for i = 1 : L
    for j = 1:M
        for k = 1 : P
            if i == 2
                results.alpha_amend(i,j,k) = find(results.m(i,j,end:-1:1,k) < 0.1, 1);
            elseif i == 6
                results.alpha_amend(i,j,k) = find(results.m(i,j,end:-1:1,k) < 0.015, 1);
            elseif i <= 5
                results.alpha_amend(i,j,k) = find(results.m(i,j,end:-1:1,k) == 0, 1);
            elseif i == 9
                results.alpha_amend(i,j,k) = find(results.m(i,j,end:-1:1,k) < 0.015, 1);
            elseif i == 10
                results.alpha_amend(i,j,k) = find(results.m(i,j,end:-1:1,k) < 0.5, 1);
            else
                results.alpha_amend(i,j,k) = find(results.m(i,j,end:-1:1,k) < 0.1, 1);
            end
        end
    end
end

results.slopes = zeros(L,P);
for i = 1:L
    for k = 1:P
        slope = polyfit(log(results.N_holder), log(results.alpha_amend(i,:,k)), 1);
        results.slopes(i,k) = slope(1);
        disp(slope(1));
    end
    hold on;
end

results.mean_slope = mean(results.slopes, 2);
results.std_slope = std(results.slopes, 0, 2);
figure;
hold on;
errorbar(results.r1_holder([1:2 4:10]), results.mean_slope([1:2 4:10]), results.std_slope([1:2 4:10]),'bs','MarkerSize',10,'MarkerFaceColor','b','LineWidth',2);
%errorbar(results.r1_holder([1:2 4:10]), results.mean_slope([1:2 4:10]), results.std_slope([1:2 4:10]),'bs','MarkerSize',10,'MarkerFaceColor','b','LineWidth',2);
% save('result_sim.mat', 'results');


