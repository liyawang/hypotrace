function [x h rr] = starting_point(im)
% Determine starting points given a 2d image
 
r = 0.9;
m = round(size(im, 1)/2);

% Binarizing
im = iWeight(im, 3);


% Estimate the initial direction
slope = extend(im);

rr = [-slope -1]'; rr = rr / norm(rr);

centerLine = im(m, :);

[Y I] = find( centerLine > 0 );

h = length(I) / sqrt(1+slope^2) / r / 2;
      
x = [mean(I); m];
%     mL = ceil(x(2)-h); mR = floor(x(2)+h);
%     nL = ceil(x(1)-h); nR = floor(x(1)+h);
%     figure, imshow(im(mL:mR, nL:nR), []), pause
return

