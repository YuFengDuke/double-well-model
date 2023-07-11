function [x,y] = get_pdf(W, sparse_matrix)

W = reset_diag(W);
[sparse_W, ~] = code_sparse(W, sparse_matrix);
l = histogram(sparse_W,1000,'Normalization','pdf');
x = zeros(size(l.BinCounts));
for i = 2:size(l.BinEdges, 2)
    x(i-1) = (l.BinEdges(i-1) + l.BinEdges(i)) / 2;
end
y = l.Values;
delta = l.BinWidth;
for X = max(x) : delta : max(x) + 1
    x = [x, X];
    y = [y, 0];
end
for X = min(x) : -delta : min(x) - 1
    x = [X, x];
    y = [0, y];
end