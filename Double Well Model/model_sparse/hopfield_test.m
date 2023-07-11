function pattern=hopfield_test(weight,I,th)
neuron_number=size(I,2);

prev_I = I;
for i=1:20
    count = 0;
%      O = randperm(neuron_number);
    O = 1:neuron_number;
    next_I = zeros(size(prev_I));
    for m = 1:neuron_number
        E = prev_I * weight(:,O(m));
        if E-th>0
            if prev_I(O(m)) ~= 1
                count = count + 1;
            end
            next_I(O(m))=1;
        else
            if prev_I(O(m)) ~= 0 
               count = count + 1; 
            end
            next_I(O(m))=0; 
        end
    end
    prev_I = next_I;
    if (count == 0)
        break;
    end
end
pattern = prev_I;
% disp(i);
% N = size(I,2);
% prev = I;
% for i = 1 : 2000
%     next = heaviside(prev * weight);
%     diff = abs(sum(next-prev)) / N;
%     if diff == 0
%         break;
%     end
%     prev = next;
% end
% pattern = next;
% disp(i);