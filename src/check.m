function check(filename)
close all
if nargin < 1
    filename = 'q';
    load LL; 
end

%% Remove non-replaced default values (untracked images)

tmp = LL==0;
LL(tmp) = [];
points(:, tmp) = [];
HA(tmp) = [];
HA0(tmp) = [];

%% Plot growth rate and hook angle

steps = 1;
[val p] = csaps(1:1:length(LL), LL, .2, 1:1:length(LL));
xle = steps:steps:steps*length(LL);
yle = val;
figure, subplot(221), plot(xle, yle, '.-')

[val p] = csaps(1:1:length(LL)-1, diff(val), .2, 1:1:length(LL)-1);
xgr = steps:steps:steps*(length(LL)-1);
ygr = val;
subplot(222), plot(xgr, ygr)
title('Growth Rate'), xlabel('Image Number'), ylabel('Growth Rate');

[out p] = csaps(steps:steps:steps*length(HA), HA-HA0, 0.1, steps:steps:steps*length(HA));
xta = steps:steps:steps*length(HA);
yta = out;
subplot(223), plot(xta, yta), 
title('Hook Angle'), xlabel('Image Number'), ylabel('Hook Angle');

%% Show hook angle tracking

figure,
points = round(points);

cSize = 150;
mov = avifile(filename, 'compression', 'none');
try
    for i = firstIM : step0: (length(points)-1)*step0
        stri = num2str(i);
        im = downread(strcat(IMpath, '\', stri, '.TIF'));
%         im = im(ymin:ymin+height, xmin:xmin+width);
        n = (i-firstIM) / step0 + 1;
        imshow(im,[]); hold on,
        plot(u_sets{n}(1, :), u_sets{n}(2, :), '-');
        plot(points(1,n), points(2,n), 'ro'), alpha = 3; beta=3; 
        quiver(points(1,n), points(2,n), 30*rs(1, n), 30*rs(2, n), 'r'),
        plot(points0(1,n), points0(2,n), 'ro'), alpha = 3; beta=3; 
        quiver(points0(1,n), points0(2,n), 30*rs0(1, n), 30*rs0(2, n), 'r')
        title(i); hold off, drawnow,
        F = getframe(gcf);
        mov = addframe(mov,F);
    end
    mov = close(mov);
catch
    mov = close(mov);
    dbstack(); rethrow(lasterror);
end

%% Write Growth Rate and Hook Angle into Excel file

xlswrite(strcat(filename, 'le'), [xle' yle']);
xlswrite(strcat(filename, 'gr'), [xgr' ygr']);
xlswrite(strcat(filename, 'ta'), [xta' yta']);
close all
return;