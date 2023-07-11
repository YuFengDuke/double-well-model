function pdf_t = pdf_time_evolve(init_w, init_pdf, r1, r2, r3, C, t)

% pdf_t0 = zeros(size(init_pdf));
% 
% MAX_W = max(init_w);
% MIN_W = min(init_w);
% 
% grid_num = 500;
% deltas = linspace(MIN_W,MAX_W,grid_num);
% 
% 
% for i = 1:size(init_w,2)
%     w = init_w(i);
%     tmp_pdf = 0;
%     for delta = deltas
%         w_p = w + r2 + delta;
%         w_n = w - r2 + delta;
%         if w_p > MAX_W || w_p < MIN_W
%             f_p = 0;
%         else
%             idxs_p_s = find(w_p < init_w);
%             idxs_p_l = find(w_p > init_w);
%             f_p = (init_pdf(idxs_p_s(1)) + init_pdf(idxs_p_l(end))) / 2;
%         end
%         if w_n > MAX_W || w_n < MIN_W
%             f_n = 0;
%         else
%             idxs_n_s = find(w_n < init_w);
%             idxs_n_l = find(w_n > init_w);
%             f_n = (init_pdf(idxs_n_s(1)) + init_pdf(idxs_n_l(end))) / 2;
%         end
%         tmp_pdf = tmp_pdf + exp(2*r1) * (0.5 * f_p + 0.5 * f_n) * 1/r3/sqrt(2 * pi) .* exp(- delta^2 / 2 / r3^2);
%     end
%     pdf_t0(i) = tmp_pdf / grid_num;    
% end
% 
% pdf_t0 = pdf_t0 / trapz(init_w,pdf_t0);

pdf_t0 = init_pdf;

MAX_W = max(init_w);
MIN_W = min(init_w);

pdf_t = zeros(size(init_pdf));
for i = 1:size(init_w,2)
    w = init_w(i);
    if (w < C*(1-exp(-2*t*r1)) && w > 0) || (w > -C*(1-exp(-2*t*r1)) && w < 0)
        continue;
    end
    if w > 0
        w_s = (w - C) * exp(2 * t * r1) + C;
    else
        w_s = (w + C) * exp(2 * t * r1) - C;
    end
    if w_s > MAX_W || w_s < MIN_W
        f = 0;
    else
        idxs_s = find(w_s <= init_w);
        idxs_l = find(w_s >= init_w);
        f = (pdf_t0(idxs_s(1)) + pdf_t0(idxs_l(end)))/2;
%         f = interp1(init_w, init_pdf, w_s, 'pchip');
     end
    pdf_t(i) = f;
end
pdf_t = pdf_t / trapz(init_w,pdf_t);