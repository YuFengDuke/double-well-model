function [mean_h, std_h] = cal_local_field(init_w, init_pdf, pattern_num, r1, r2, r3, C)


pdf_t0 = move_distribution(init_w, init_pdf, r2);
pdf_t0 =  add_noise(init_w, pdf_t0, r3);
pdf_t0 = pdf_time_evolve(init_w, pdf_t0, r1, r2, r3, C, 1);

pdf_t = pdf_t0;
mean_h = zeros(1, pattern_num);
std_h = zeros(1, pattern_num);
for i = 1:pattern_num
    pdf_t =  pdf_t / trapz(init_w,pdf_t);
    mean_h(i) = trapz(init_w, init_w .* pdf_t);
    std_h(i) = sqrt((trapz(init_w, init_w.^2 .* pdf_t) - mean_h(i)^2));
    pdf_t =  add_pattern(init_w, pdf_t, r2);
    pdf_t =  add_noise(init_w, pdf_t, r3);
    pdf_t = pdf_time_evolve(init_w, pdf_t, r1, r2, r3, C, 1);
end

%%inbalance correction
% mean_h = max(mean_h, 0);
    
% mean_h = mean_h * c * f;
% std_h = sqrt(c*f/N) * std_h;