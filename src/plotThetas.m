function shifts = plotThetas(thetas, path)
% Plot tip angle curves and make sure that they are lined up correctly

if nargin < 2, path = ''; end

if length(thetas) < 3, return; end

str = 'rg';
NN = size(thetas, 2) - 1;
n = 1;

for i = 1 : NN
    xx = thetas(:,1);
    yy1 = thetas(:,i+1)*180/pi;
    [sp yy2] = spaps(xx, yy1, 50, 3);
    figure(10), plot(xx, yy1, '.', xx, yy2, strcat(str(i), '-')); hold on
    figure(20), plot(xx(1:end-1), sti(yy2), strcat(str(i), '-')); hold on
end
figure(10), title(path(17:end));
figure(20), title(path(17:end));
return;

function s = sti(yy)
% Calculate root response corresponding to stimulation

t1 = yy(1:end-1);
t2 = yy(2:end);
s = (sin(t2) - sin(t1))./(t2 + t1);
s = abs(fftshift(fft(s)));

return;
