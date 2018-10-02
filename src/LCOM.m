function u_x = LCOM(X, kh)
% Return local center of mass around x given a d-dimensional data cloud X
% H is a bandwidth matrix

% n = max(size(X));
% kh = KH(X-x*ones(1, n), H);
try
    u_x = sum((ones(min(size(X)), 1)*kh) .* X, 2) / sum(kh);
catch
    dbstack(); save lcom; rethrow(lasterror);
end

return;