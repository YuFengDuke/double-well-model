function range_x = get_range_x(r1)
if r1 <= 6e-4
    range_x = 45;
elseif r1 <= 1e-3
    range_x = 40;
elseif r1 <= 5e-3
    range_x = 35;
elseif r1 <= 1e-2
    range_x = 25;
elseif r1 < 1e-1
    range_x = 15;
elseif r1 < 0.5
    range_x = 6;
else
    range_x = 5;
end