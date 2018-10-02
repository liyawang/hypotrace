close all, clear all

IMpath = 'M:\liya\gwu\';

[xmin ymin width height] = checkRect(IMpath);
% width = min(width, height);
% height = width;

im0 = downRead(strcat(IMpath, '\1.TIF'));
im = im0(ymin:ymin+height, xmin:xmin+width); 
tic, [x h rr im] = starting_point(im); toc

figure, imshow(im0, []);  hold on, plot(x(1)+xmin, x(2)+ymin, 'o'), hold off
drawnow,
% hold on, plot(round(x), height, 'ro'), hold off