function kh = KH(X, H, sigma)
% d-dimensional kernel function given a bandwidth matrix H

if nargin < 3
    sigma = 0.5;  % smaller sigma --> heavy weights
end
try
    kh = diag(X'*inv(H)*X)';
catch
    size(X),
    rethrow(lasterror);
end
kh = 1/(2*pi*norm(H)*sigma) * exp(-1/2*kh/sigma);
% kh = (kh - min(kh)) / (max(kh) - min(kh)) + .1;
% kh = ones(1, length(kh));
return