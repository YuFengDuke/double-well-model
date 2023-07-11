function pdf = add_noise(init_w, init_pdf, r3)

if r3 == 0
    pdf = init_pdf;
end

if r3 ~= 0
    pdf_t0 = zeros(size(init_pdf));

    MAX_W = max(init_w);
    MIN_W = min(init_w);

    grid_num = 500;
    deltas = linspace(MIN_W,MAX_W,grid_num);


    for i = 1:size(init_w,2)
        w = init_w(i);
        tmp_pdf = 0;
        for delta = deltas
            w_p = w + delta;
            if w_p > MAX_W || w_p < MIN_W
                f_p = 0;
            else
                idxs_p_s = find(w_p < init_w);
                idxs_p_l = find(w_p > init_w);
                f_p = (init_pdf(idxs_p_s(1)) + init_pdf(idxs_p_l(end))) / 2;
            end

            tmp_pdf = tmp_pdf +  (f_p) * 1/r3/sqrt(2 * pi) .* exp(- delta^2 / 2 / r3^2);
        end
        pdf_t0(i) = tmp_pdf / grid_num;    
    end

    pdf = pdf_t0 / trapz(init_w,pdf_t0);
end