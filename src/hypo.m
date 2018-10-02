function hypo(IMpath, dispL, firstIM, lastIM, step0)
warning off
close all
if nargin<1
    IMpath = '..\data\cry1-gwu\060417 10min 2hD 12h 50uMBL cry1 444444';
    IMpath = 'N:\liya\data\91807WT';
end
if nargin<2, dispL = 0; end
if nargin<3, firstIM = 0; end
if nargin<4
    d = dir(strcat(IMpath, '\*.tif'));
    lastIM = length(d)-1;
end
if nargin<5, step0 = 1; end

dispL = str2double(num2str(dispL));
firstIM = str2double(num2str(firstIM));
lastIM = str2double(num2str(lastIM));
step0 = str2double(num2str(step0));
lastIM
[GR u_sets HA] = growthRate(IMpath, firstIM, lastIM, dispL, step0);

return;