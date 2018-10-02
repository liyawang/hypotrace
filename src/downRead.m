function im = downRead(file)

% Down sampling
down = 1;
im = imread(file);

im = double(im(1:down:end, 1:down:end)); 

return;