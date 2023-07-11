function m = local_field_recursion(m, mean_h, std_h)



% f_1 = 1 - normcdf(0,  mean_h * (1 + m) / 2, std_h * ((1 + m) / 2));
% f_2 = 1 - normcdf(0, -mean_h * (1 - m) / 2, std_h * ((1 - m) / 2));
% 
% f_p = (1+m) /2 * f_1 +  (1-m)/2 * f_2;

f_p = 1 - normcdf(0, mean_h * m, std_h * sqrt((1+m^2)/2));

mis_percentage = 1- f_p;
m = 1 - 2 * mis_percentage;


