function [L, pointSet, sp] = arcLength(pointSet)

% Calculate the length of the principal curve given a set of points

df = pointSet(:, 2:end) - pointSet(:, 1:end-1);
df = df.^2;
L = [0 cumsum(sqrt(sum(df, 1)))];

[sp pointSet] = spaps(L, pointSet, 50);

return