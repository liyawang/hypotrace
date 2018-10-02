function [xmin ymin width height] = checkRect(im)
% Select and resize rectangles to fall within images

figure;
imshow(im, []); hold on

rect = floor(getrect());

[m n] = size(im);
xmin = rect(1);
ymin = rect(2);
width = rect(3);
height = rect(4);

if xmin < 1, xmin = 1; end
if ymin < 1, ymin = 1; end
if xmin+width > n, width = n - xmin; end
if ymin+height > m, height = m - ymin; end

close;

return;