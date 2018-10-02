function Y = robustBaseline(X, y, h, b)

% Performing robust local regression estimation for baseline extraction
% y = g(X) + signal + noise; Y = g(X), the baseline
% b is the robustness of the fitting of local linear segments
% h is the kernel width, which should be set as half of peak width

if nargin < 4, b = 10; end
if nargin < 3, h = 4; end

N = length(X);

if N < h+1, Y = y; return; end
if abs(N-length(y)) > 0, exit(0); end

hh = h * (1+cos((pi+2*pi/N*[0 cumsum(ones(1,N))])))/2 + 1;
hh = floor(hh);
% hh = ones(1, N)*h;

hh = [zeros(1, h) hh zeros(1, h)];
Y = [];

tune = 1; 

X = [fliplr(X(1:h)) X fliplr(X(end-h:end))];
y = [fliplr(y(1:h)) y fliplr(y(end-h:end))];

N = length(X);
for i = h+1 : N-h-1
    h = hh(i);
    leftI = i-h;
    rightI = i+h;
    x = X(leftI:rightI);
    yy = y(leftI:rightI);
    x0 = X(i);    
    u = (x' - x0) / h;    
    %save u u
    try
        YY = robustfit(x, yy, @rbe, tune);
    catch
        dbstack(); save debug; rethrow(lasterror);
    end
    Y = [Y YY(2)*x0+YY(1)];
end

%return;

function w = rbe(r)
%load u
K = inline('max(1 - abs(u).^3, 0).^3');

if r < 0
    w = K(u);
else
    w = max(1 - (r.*r)/(b*b), 0).*K(u);
end

%return
end

end
