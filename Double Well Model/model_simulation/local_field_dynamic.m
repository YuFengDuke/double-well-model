function output = local_field_dynamic(W, input)

N = size(input,2);

prev_I = input;
for i=1:1
    next_I = zeros(size(prev_I));
    for m = 1:N
        h = prev_I * W(:,m);
        if h > 0
            next_I(m)=1;
        else
            next_I(m)=0; 
        end
    end
    prev_I = next_I;
end

output = prev_I;