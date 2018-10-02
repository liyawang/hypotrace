function s = modEdge(s)
% This function performs edge modification at the end of the signal by
% adding a simulated peak

k = 3;
e = s(end);
tmp = s(end-k:end-1);
for i = 1 : k
    s = [s 2*e-tmp(end-i+1)]; 
end

for i = 1 : k
    s = [s s(end)+s(end)-s(end-1)];
end

for i = 1 : k * 2
    s = [s s(end)-(s(end)-s(end-1))];
end

for i = 1 : k
    s = [s s(end)];
end

return