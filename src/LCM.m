function sigma = LCM(X, u, kh)
% Calculate local covariance matrix
% kh = KH(X-x*ones(1, n), H);

[m n] = size(X);

w = kh / sum(kh);

% sigma = ((ones(m, 1)*w).*(X-u*ones(1, n)))';

sigma = wcov(X, u*ones(1, n), ones(m, 1)*w);

return