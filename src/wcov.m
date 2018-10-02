function xy = wcov(x, u, w)
%WCOV Weighted covariance matrix
%   WCOV(X, U, W) gives the weighted covariance matrix,
%
%   sigma_j_k = sum_i=1-n w_i(X_i_j - u_j)(X_i_k - u_k)
%

xc = x - u;

xy = (w .* xc) * xc';

return;