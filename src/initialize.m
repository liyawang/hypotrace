function [mim th] = initialize(im, ws)
% Determine rough threshold and cotyledon intensity

mim = imfilter(im,fspecial('average',ws), 'replicate');
mim = double(mim);
th = max(max(mim)) - (max(max(mim)) - min(min(mim))) * 0.5;
% figure, imshow(im<th, []); pause
% sum(sum(im<th))
return;





