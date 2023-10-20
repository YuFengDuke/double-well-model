function W_con  = multi_state_consolidation_func(W,r1,C_list,dt)

if nargin < 4
    dt = 1;
end
 
b_list = ones(size(C_list));
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
minimum_location = minimum_location - middle_point;

W_con = zeros(size(W));

index = find(W<= (minimum_location(1) + C_list(1)));
W_con(index) = exp(-2*dt*b_list(1)*r1).*(W(index) - minimum_location(1)) + minimum_location(1);

for i = 2:num_state-1
    if C_list(i) ~= 0 
        index = find((W<=(minimum_location(i) + C_list(i)))&(W> (minimum_location(i) - C_list(i))));
        W_con(index) = exp(-2*dt*b_list(i)*r1).*(W(index) - minimum_location(i)) + minimum_location(i);
    end
end


index = find(W > (minimum_location(end) - C_list(end)));
W_con(index) = exp(-2*dt*b_list(end)*r1).*(W(index) - minimum_location(end)) + minimum_location(end);
