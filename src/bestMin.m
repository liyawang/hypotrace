function [val I] = bestMin(Y)

% Determine the minimal transition state of a given series of states
%
% The goal is to look for a state with local minimal value but requiring 
% a huge energy barrier to overcome for jumping to even lower energy
% states

[p val] = spaps(1:1:length(Y), Y, 2);
N = length(val);
[ma I0] = max(val(round(N/2):end));

[firstMin I] = min(val(2:I0+round(N/2)-1));

I = I + 1;

x = I+1:1:length(val);
y = val(I+1:end)-val(I);

y1 = [y(1) y];
y2 = [y y(end)];

minset = find(diff(y1)<0 & diff(y2)>0) + I;
% figure, plot(val)
for i = 1 : length(minset)
    nextMin = val(minset(i)); 
    midMax = max(val(I+1:minset(i)));
    jump = (midMax - nextMin) / (nextMin - firstMin);
    if jump > 1 & midMax < max(val(minset(i):end)) 
        firstMin = nextMin;
        I = minset(i);
    end
end

return
