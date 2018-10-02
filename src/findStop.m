function stop = findStop(out)
% Find a stop point - a local maximal
lt = diff(out(1:end-1));
rt = diff(out(2:end));
targets = find((lt>=0 & rt<0)|(lt>0 & rt<=0));
targets = targets + 1;
[Y I] = sort(out(targets), 'descend');
stop = targets(I);

return
