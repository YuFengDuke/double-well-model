function pdf = add_pattern(init_w, init_pdf, r2)

pdf_p = move_distribution(init_w, init_pdf, r2);
pdf_n = move_distribution(init_w, init_pdf, -r2);

pdf = 0.5 * (pdf_p + pdf_n);