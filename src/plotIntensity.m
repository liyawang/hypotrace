function stop = plotIntensity(im, u_sets, wd, x, disp)

ML = round(u_sets);
im = double(im);
ind = [];

for i = 1 : length(ML)
    [inm ins] = intensity(im, ML(:, i));
    ind = [ind inm];
end

N = length(ind);

if length(ind) < 5
    stop = N;
    return;
end

% Edge modification
ind = modEdge(ind);

yy=robustBaseline(1:1:length(ind), ind, wd);
for i=1:1
    yy=robustBaseline(1:1:length(ind), yy, wd);
end
spec = ind-yy;

ind = ind(1:N); spec = spec(1:N); yy = yy(1:N);

tmpx = min(x):1:max(x);

spec = ([0 spec(1:end-1)] + spec + [spec(2:end) 0]) / 3;
[out p] = csaps(x, spec, 0.01, tmpx);

stop = findStop(out);

if disp || isempty(stop)
    figure, subplot(221), plot(x, ind, '.-'); hold on, 
    plot(x, yy, 'r-');title('Intensity');  %plot(x, yy1, 'g-');  
    subplot(222), plot(x, yy, '.-'); title('Baseline');
    subplot(223), plot(x, spec, 'r.-'); hold on
    plot(tmpx, out)
    
    plot(tmpx(stop), out(stop), 'ro');
end

stop = tmpx(stop);

return