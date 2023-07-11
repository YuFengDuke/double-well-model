function [init_w, init_pdf, converge] = get_asym_dist(r1, r2, r3, C)

range_x = get_range_x(r1) * 2;

if r3 == 0
    tolerance = 1e-6;
else
    tolerance = 1e-3;
end

converge = true;
init_w = linspace(-range_x,range_x,4000);
init_pdf = randn(size(init_w));

for i = 1:5000
    [iter_pdf, error] = recursion_relation(init_w, init_pdf, r1, r2, r3, C);
    init_pdf = iter_pdf;
    if error < tolerance
        break;
    end
    if i > 1000 && error > 0.1
        converge = false;
        break;
    end
end