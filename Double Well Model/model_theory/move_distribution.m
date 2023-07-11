function new_pdf = move_distribution(w, pdf, dist)

MAX_W = max(w);
MIN_W = min(w);

new_pdf = zeros(size(pdf));

if dist < 0
    idxs = find(w > (abs(dist) + MIN_W));
    len_idxs = size(idxs,2);
    new_pdf(1:len_idxs) = pdf(idxs);
end


if dist > 0
    idxs = find(w < (MAX_W - abs(dist)));
    len_idxs = size(idxs,2);
    new_pdf(end-len_idxs+1:end) = pdf(idxs);
end