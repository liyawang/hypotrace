function [angle point r angle0 point0 r0] = hookAngle(u, r, x)

% Given ordered data set u and direction r at each point, estimate the
% direction at point x, which might not belongs to u.

win = 22;
wd = 3;

N = length(u);

tmp = dist(u', x);

[d I] = sort(tmp);

r1 = r(:, I(1));
r2 = r(:, I(2));
d1 = d(1) / sum(d(1:2));
d2 = d(2) / sum(d(1:2));

r0 = mean(r(:, max(1, I(1) - win - wd) : min(I(1) - win + wd, N)), 2);
r = (d2*r1) + (d1*r2);

angle = acos( r(2) / sqrt(sum(r.^2)) );
angle = angle * 180 / pi;


angle0 = acos( r0(2) / sqrt(sum(r0.^2)) );
angle0 = angle0 * 180 / pi;

u1 = u(:, I(1));
u2 = u(:, I(2));

point = (d2*u1) + (d1*u2);
point0 = u(:, max(1, I(1) - win));

return