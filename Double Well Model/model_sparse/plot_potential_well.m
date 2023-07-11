function [x,y] = plot_potential_well(C_list, minimum_shift)

b_list = ones(size(C_list));
shift_distance = max(C_list.^2) - (b_list).*C_list.^2;
num_state = size(C_list,2);

if num_state == 1
    if C_list(1) ~= 0
        disp('error');
    end
end

if (mod(num_state,2) == 0)
    middle_point = sum(2*C_list(1:floor(num_state/2)));
else
    middle_point = sum(2*C_list(1:floor((num_state-1)/2)))+C_list(floor((num_state+1)/2));
end

minimum_location = zeros(1,num_state);
minimum_location(1) = C_list(1);
for i = 2:num_state
    minimum_location(i) = minimum_location(i-1) + C_list(i-1) +C_list(i); 
end
minimum_location = minimum_location - middle_point + minimum_shift;

if all(C_list==0)
    x = linspace(minimum_location(1) - C_list(1) -0.1, minimum_location(end) + C_list(end) + 0.1,500);
else
    x = linspace(minimum_location(1) - C_list(1), minimum_location(end) + C_list(end),500);
end

potential_holder = [];
index = find(x <= minimum_location(1) + C_list(1));
potential = (x(index) - minimum_location(1)).^2  + shift_distance(1);
potential_holder = [potential_holder,potential];
for i = 2:num_state-1
    if C_list(i) ~= 0 
        index = find((x <= minimum_location(i) + C_list(i))&(x > minimum_location(i) - C_list(i)));
        potential = (x(index) - minimum_location(i)).^2 + shift_distance(i);
        potential_holder = [potential_holder,potential];
    end
end

index = find(x > minimum_location(end) - C_list(end));
potential = (x(index) - minimum_location(end)).^2 + shift_distance(end);
potential_holder = [potential_holder,potential];


plot(x,potential_holder - max(C_list.^2),'LineWidth',2);

y = potential_holder;