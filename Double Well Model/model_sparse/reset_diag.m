function W = reset_diag(W)

for i = 1:size(W,1)
    W(i,i) = 0;
end

W = W-mean(mean(W));

for i = 1:size(W,1)
    W(i,i) = 0;
end