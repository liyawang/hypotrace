function r = nextstep(r0, r, k)
% Get next direction by taking into account following situations
% 1. Avoiding running backwards from x0 (solved by initial condition)
% 2. Maintaining the direction
% 3. Angle penalization for forcing stright walking while crossing

if nargin < 3, k = 1; end

cosa = r0'*r;
if abs(cosa)<.001, r = r0; return; end
% 2
if cosa < 0
    r = -1 * r;
    cosa = r0'*r;
end

% 3
ax = abs(cosa)^k;

if ax > 0
    r = ax * r + (1-ax) * r0;
end    

return