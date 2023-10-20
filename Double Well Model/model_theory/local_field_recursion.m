function [mt, m1] = local_field_recursion(mt, m1, mean_h, std_h, r2)


p11 = (1 + mt) * (1 + m1) / 4;
p10 = (1 + mt) * (1 - m1) / 4;
p01 = (1 - mt) * (1 + m1) / 4;
p00 = (1 - mt) * (1 - m1) / 4;

% std_h = std_h * sqrt(p11^2 + p10^2 + p01^2 + p00^2);
mean_h11 = p11 * (mean_h + r2) + p10 * (mean_h - r2) + p01 * (-mean_h + r2) + p00 * ( -mean_h - r2);
mean_h10 = p11 * (mean_h - r2) + p10 * (mean_h + r2) + p01 * (-mean_h - r2) + p00 * ( -mean_h + r2);
mean_h01 = p11 * (-mean_h + r2) + p10 * (-mean_h - r2) + p01 * (mean_h + r2) + p00 * ( mean_h - r2);

mt = 1 - normcdf(0, mean_h11, std_h) - normcdf(0, mean_h10, std_h);
m1 = 1 - normcdf(0, mean_h11, std_h) - normcdf(0, mean_h01, std_h);

