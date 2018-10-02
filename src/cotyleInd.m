function [cotyle ind touchPoint] = cotyleInd(im, imb, notFirst)
% Estimate cotyledons pixel intensity and return touch point (really below)
%  Note: Gaussian fitting is used for the first image for intensity peak
%  estimation only.

w = sum(imb, 2);
wc = diff(w);
wd = mean(w(end-5:end));
[Y topPoint] = max(wc);
touchPoint = topPoint + 4*wd;
if nargin > 2  
    cotyle = touchPoint; ind = touchPoint;
    return;
end

imb(1: topPoint, :) = 0;
imb(touchPoint:end, :) = 0;

[m n] = size(im);
imb(m+1:end, :) = [];
im = reshape(double(im), m*n, 1);
[Y X] = hist(im(imb>0), 150);

y = csaps(X, Y, .01, X);
X0 = [X(round(length(X)/3)) 5 10 X(round(length(X)/2)) 10 30];

% Gaussian fitting for peak locating
try
    x = lsqcurvefit(@sumGauss, X0, X, y/max(y));
    cotyle = x(1); ind = x(4);
catch
    dbstack(); save cotyleInd; rethrow(lasterror);
end

% figure, plot(X, y/max(y), '.'); pause; close
return;

function [y, y1, y2] = sumGauss(x, X)
y1 = Gauss(x(1:3), X);
y2 = Gauss(x(4:6), X);
y = y1 + y2;
return;

function y = Gauss(x, X)
m = x(1); s = x(2); r = x(3);
y = r * (exp(-(X-m).^2/(2*s^2)))/(s*sqrt(2*pi));
return;