function stop = manualStop(im, u_set, sp, stop, preS)
% Manually locating the stop point.

figure(2), imshow(im, []); hold on
stopL = zeros(2, length(stop));
plot(u_set(1,:), u_set(2, :));
for iii = 1 : length(stop)
    sL = fnval(sp, stop(iii));
    plot(sL(1), sL(2), 'ro');
    stopL(:, iii) = sL;
end
if nargin > 4
    sL = fnval(sp, preS);
    plot(sL(1), sL(2), 'r*');
end

[x, y] = ginput(1);
dst = dist(stopL', [x; y]);
dss = dist(u_set', [x; y]);
if min(dst) < 2*min(dss)
    stop = stop(dst == min(dst));
else
    [stopV I] = min(dss);
    [stop pts sp] = arcLength(u_set(:, 1:I));
    stop = stop(end);
end

close 

return