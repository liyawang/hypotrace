function [GR u_sets HA] = growthRate(IMpath, firstIM, lastIM, dispL, step0)
% Calculate growth rate and hook angle for a given set of images.
% Assume IM name are consecutive integers

N = length(firstIM : step0 : lastIM);
LL = zeros(1, N); HA = LL;  HA0 = LL; stops = zeros(N, 2); 
rs = zeros(2, N); rs0 = rs; points0 = rs; points = rs; u_sets = cell(N, 1);

nim = length(0 : step0 : lastIM);
nmim = num2str(nim);

predictL = 3; 

for i = firstIM : step0 : lastIM
    index = (i-firstIM)/step0+1;
    stri = num2str(i);
    strii = num2str(i+1);
    disp(strcat(strii, '/', nmim));     
    
    im0 = downRead(strcat(IMpath, '/', num2str(i), '.TIF'));
    if index < 2
        [xmin ymin width height] = checkRect(im0);
    end
        
    im = im0(ymin:ymin+height, xmin:xmin+width);
    [x h r] = starting_point(im);
    x = x + [xmin; ymin];
    
    [u_set r_set w_set h_set] = ...
        LPC(im0, x, h, r, dispL, LL(1:index-1), predictL);
   
    wd = 8;
    wd2 = wd * 4/4;
    wd3 = wd * 6/4;
    uu = u_set;
    wh = h_set;
    [L u sp] = arcLength(uu);
    if index < 2
        [wh I] = bestMin(wh);
        I = I + wd;
    else
        I = find(stop<=L, 1);
        if length(I) < 1, I = length(u)-wd3; end
    end
    u_sets{(i-firstIM)/step0+1} = u;
    leftI = 1;
    rightI = length(u);
    if I <= wd2,
        if I+wd3+wd2 < length(u)
            rightI = I + wd3 + wd2;
        end
    else
        if I+wd3 > length(u)
            if wd3+wd2 < length(u)
                leftI = rightI - wd2 - wd3;
            end
        else
            rightI = I+wd3;
            leftI = I-wd2;
        end
    end

    x = L(leftI : rightI);
    u = u(:, leftI:rightI);
    
    stop = plotIntensity(im0, u, wd, x, dispL); 

    if dispL
        subplot(224), plot(L, wh, '.-'), title('Width');
        print(GCF, '-djpeg', num2str(i));
        close all
    end

    if length(LL(1:index-1))>predictL
        tmp = LL(index-predictL:index-1);
        stopxy = fnval(sp, stop(1));
        B = robustfit(1:1:length(tmp), tmp);
        preS = B(2)*(length(tmp)+1) + B(1);
        [stopY stopI] = min(abs(preS - stop));

        diffLL = mean(abs(diff(LL(1:end-3))));
        stdLL = std(abs(diff(LL(1:end-3))));
        if sum((stops(end, :) - [stopxy(1) stopxy(2)]).^2) > 50 ...
                || abs(stop(stopI) - LL(end)) < diffLL + 2 * stdLL
            if stopY < diffLL + stdLL * 2
                if LL(end) < stop(stopI)
                    stop = stop(stopI);
                else
                    stop = LL(end)+mean(abs(diff(tmp(end-predictL:end))))/2;
                end
            else
                stop = manualStop(im0, u_set, sp, stop, preS);
            end
        else
            stop = stop(stopI);
        end
    else
        stop = manualStop(im0, u_set, sp, stop);
    end
    LL(index) = stop;
    stopxy = fnval(sp, stop);
    stops(index, :) = [stopxy(1) stopxy(2)];
    [angle point r angle0 point0 r0] = hookAngle(uu, r_set, fnval(sp, stop));
    HA(index) = angle;
    HA0(index) = angle0;
    points(:, index) = point;
    points0(:, index) = point0;
    rs(:, index) = r;
    rs0(:, index) = r0;
    
    save LL LL u_sets points HA xmin ymin width height...
        rs HA0 points0 rs0 firstIM step0 IMpath stops

end
GR = LL;

return

