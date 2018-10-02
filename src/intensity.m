function [inm ins] = intensity(im, u, w)

% Estimate local intensity for point u(x, y) within given image

if nargin < 3, w = 2; end
n = round(u(1)); m = round(u(2));

[M N] = size(im);

tmp = im(max(m-w, 1):min(m+w, M), max(n-w, 1):min(n+w, N));
tmp = reshape(tmp, size(tmp,1)*size(tmp,2), 1);
% tmp(find(abs(tmp-mean(tmp)) > std(tmp))) = [];
inm = mean(tmp);
ins = std(tmp);

return;