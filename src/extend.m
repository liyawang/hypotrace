function slope = extend(im)
% Estimate the initial direction

se = strel('disk',2);
im = imclose(im,se);
df = diff(im, 1, 2);

[x1 y1] = find( df > 0 ); n1 = length(x1); 
[x2 y2] = find( df < 0 ); n2 = length(x2);

p1 = polyfit(x1, y1, 1);
p2 = polyfit(x2, y2, 1);

slope = (p1(1) + p2(1)) / 2;

return