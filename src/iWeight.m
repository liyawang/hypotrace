function w = iWeight(im, ws, mim, xc, th)
% intensity weighting around xc based on similarity
% input 
%   im - input matrix
%   ws - square size for similarity estimation
%   th - threshold for both background and cotyledon
% output
%   w - weighting matrix

[m n] = size(im);
w = zeros(m, n);

if nargin < 3
    mim = imfilter(im,fspecial('average',ws), 'replicate');
    th = max(max(mim)) - (max(max(mim)) - min(min(mim))) * 0.5;
    w(mim < th) = 1;
else
    mL = max(1, xc(2)-ws); mR = min(xc(2)+ws, m);
    nL = max(1, xc(1)-ws); nR = min(xc(1)+ws, n);
    im0 = im(mL:mR, nL:nR);
    [m n] = size(im0);
    im1 = reshape(im0, m*n, 1);

    mn = mean(im1);
    sd = std(im1);

    tL = mn - 2*sd;
    w(mim<th) = 1;
    w(mim<tL) = exp((mim(mim<tL)-mn)/(2*sd));
end

return;
