function [iter_pdf,error] = recursion_relation(init_w, init_pdf, r1, r2, r3, C)

iter_pdf = zeros(size(init_pdf));
MAX_W = max(init_w);
MIN_W = min(init_w);


%%with input noise case
if r3 ~= 0
    grid_num = 2000;
    deltas = linspace(MIN_W,MAX_W,grid_num);
    for i = 1:size(init_w,2)
        w = init_w(i);
        if (w < C*(1-exp(-2*r1)) && w > 0) || (w > -C*(1-exp(-2*r1)) && w < 0)
            continue;
        end
        if w > 0
            w_s = (w - C) * exp(2 * r1) + C;
        else
            w_s = (w + C)* exp(2 * r1) - C;
        end
        tmp_pdf = 0;
        for delta = deltas
            w_p = w_s + r2 + delta;
            w_n = w_s - r2 + delta;
            if w_p > MAX_W || w_p < MIN_W
                f_p = 0;
            else
                idxs_p_s = find(w_p < init_w);
                idxs_p_l = find(w_p > init_w);
                f_p = (init_pdf(idxs_p_s(1)) + init_pdf(idxs_p_l(end))) / 2;
            end
            if w_n > MAX_W || w_n < MIN_W
                f_n = 0;
            else
                idxs_n_s = find(w_n < init_w);
                idxs_n_l = find(w_n > init_w);
                f_n = (init_pdf(idxs_n_s(1)) + init_pdf(idxs_n_l(end))) / 2;
            end
            tmp_pdf = tmp_pdf + exp(2*r1) * (0.5 * f_p + 0.5 * f_n) * 1/r3/sqrt(2 * pi) .* exp(- delta^2 / 2 / r3^2);
        end
        iter_pdf(i) = tmp_pdf / grid_num;    

    end
    iter_pdf = iter_pdf / trapz(init_w,iter_pdf);
    error = norm(iter_pdf - init_pdf);
end

%%without input noise case
if r3 == 0
    for i = 1:size(init_w,2)
        w = init_w(i);
        if (w < C*(1-exp(-2*r1)) && w > 0) || (w > -C*(1-exp(-2*r1)) && w < 0)
            continue;
        end
        if w > 0
            w_s = (w - C) * exp(2 * r1) + C;
        else
            w_s = (w + C)* exp(2 * r1) - C;
        end

        w_p = w_s + r2;
        w_n = w_s - r2;
        if w_p > MAX_W || w_p < MIN_W
            f_p = 0;
        else
            idxs_p_s = find(w_p < init_w);
            idxs_p_l = find(w_p > init_w);
            f_p = (init_pdf(idxs_p_s(1)) + init_pdf(idxs_p_l(end))) / 2;
%             f_p = interp1(init_w, init_pdf, w_p, 'pchip');
        end
        if w_n > MAX_W || w_n < MIN_W
            f_n = 0;
        else
            idxs_n_s = find(w_n < init_w);
            idxs_n_l = find(w_n > init_w);
            f_n = (init_pdf(idxs_n_s(1)) + init_pdf(idxs_n_l(end))) / 2;
%               f_n = interp1(init_w, init_pdf, w_n, 'pchip');
        end
        iter_pdf(i) = exp(2*r1) * (0.5 * f_p + 0.5 * f_n);    

    end
    iter_pdf = iter_pdf / trapz(init_w,iter_pdf);
    error = norm(iter_pdf - init_pdf);
end