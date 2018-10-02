function iWeight = intWeight(im, Xc, cotyle, ind)
% Return intensity weight for given set of pixels

M = size(im, 1);
n = size(Xc, 2);
iWeight = ones(1, n);

index = Xc(2, :) + (Xc(1, :)-1)*M;
tmps = double(im(index));
tmp = find(tmps < ind & tmps > cotyle);
iWeight(tmps <= cotyle) = 0;
iws = iw(tmps(tmp), cotyle, ind);
iWeight(tmp) = iws;

return;

function iws = iw(cotyleSet, cotyle, ind)

iws = ((cotyleSet - cotyle) ./ (ind - cotyle)) .^ .5;

return;
