function dhist(im)
% check density histgram given part of an image
warning off
close all
im = double(imread(im));

ws = 120;
N = 2;
while 1
    imshow(im, []);

    rect = floor(getrect());

    [xmin ymin width height] = checkRect(rect, im);
    rect = [xmin ymin width height];
   
    im2 = im(ymin:ymin+height, xmin:xmin+width);    
    
    [m n] = size(im2);
    mm = round(m/2); nn = round(n/2);
    im3 = im2(mm-N:mm+N, nn-N:nn+N)
    im3 = reshape(im3, (2*N+1)^2, 1);
    
    
    subplot(211), imshow(im2, []);
    im2 = reshape(im2,m*n, 1);
    im2(im2>80) = [];
    subplot(212), hist(im2, max(im2)-min(im2));
    
    title(strcat(num2str(mean(im3)-2*std(im3)), '-', num2str(mean(im3)+2.5*std(im3))));
    pause, close 
end

warning on