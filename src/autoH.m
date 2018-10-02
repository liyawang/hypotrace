function [Xc H r] = autoH(X, x, H)

h = H(1, 1);
r = [0; 0];
Xc = X(:, find(sum((X-x*ones(1, max(size(X)))).^2, 1) < h));
%nm = sqrt(Xc(1, :).^2 + Xc(2, :).^2);
rx = 1*sum(Xc(1, :));
ry = 1*sum(Xc(2, :));
rr = sqrt(rx^2 + ry^2);

rx = rx / rr;
ry = ry / rr;
r = [rx; ry];

H = h*eye(size(H,1));
return