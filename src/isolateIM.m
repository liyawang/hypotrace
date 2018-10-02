function [im rows slope] = isolateIM(im0)
% Isolate the region of interest, the biggest region

% binarize %consider down sampling
im = adaptivethreshold(double(im0), 125);
% close all, imshow(im, []), pause

[m n] = size(im);

% label
myLabel = bwlabel(im);

N = max(max(myLabel));

if N > 1
    tmp = zeros(N, 1);
    for i = 1 : N
        tmp(i) = length(find(myLabel(:, 10:end-10) == i));
    end
    [Y I] = max(tmp);
    myL = reshape(myLabel, m*n, 1);
    im0 = reshape(im, m*n, 1);
    im0(myL~=I) = 0;
    im = reshape(im0, m, n);
end

% Extend hypocotyl for short stems to achieve better starting conditions
rows = round(sum(im(end, :))/1.8);
[im slope] = extend(im, rows);

return;