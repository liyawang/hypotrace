function [u_set r_set w_set h_set] = LPC(im0,x,h,r,disp,old_stop)
% Calculate local principal curves for a given binary image

H = h*h*eye(2);
h0 = h;
v0 = h / 4; v = v0;

u_set = []; r_set = []; w_set = []; h_set = h;

cc = 0; 

kkk = 0; Len = 0;
[mim th] = initialize(im0, round(h/4));

if disp
    % figure(1), imshow(im0<th, []); hold on
    figure(1), imshow(im0, []); hold on
end

[m n] = size(im0);

while 1
    mL = max(2, floor(x(2)-h)); mR = min(ceil(x(2)+h), m);
    nL = max(2, floor(x(1)-h)); nR = min(ceil(x(1)+h), n); 
    im = iWeight(im0(mL:mR, nL:nR), 3, mim(mL:mR, nL:nR),...
        x - [nL-1; mL-1], th);
%     figure, imshow(im, []), pause(.1), close
    nr = size(r_set, 2);
    [X Y] = find(im>0);
    X = [Y X]';
    xc = (x - [nL-1; mL-1])*ones(1, size(X,2));
    Xc = X(:, sum((X-xc).^2, 1) < H(1,1));
    rs = [1; 1];
    if nr > 3             
        % Adaptively adjust kernel size
        H = H * (w_set(end) / (100 - w_set(end))) ...
            / (w_set(end-1) / (100 - w_set(end-1))); % Adaptive
                    
        % Stop midline tracking
        if length(old_stop) < 1
            tmp = dist(u_set(:, 1:end-3)', u_set(:, end));
            if min(tmp) < dist(u_set(:, end)', u_set(:, end-2))
                break; 
            end
        else
            if old_stop(end) < Len
                kkk = kkk + 1;
                if kkk > 5  % pass last stopping point five more steps
                    break;
                end
            else
                Len = Len + dist(u_set(:, end)', u_set(:, end-1));
            end
        end
        
        h = sqrt(H(1,1));
        v = h / 4; 
    else
        if nr > 1
            Len = Len + dist(u_set(:, end)', u_set(:, end-1));
        end
    end  
    
    % Roughly estimate curvature
    sigma = 0.5;
    if nr > 2
        sigma = exp(abs(r_set(:, end)'*r_set(:, end-2)) - 1)^10/2;
    end

    % Distance weighting by Gaussian kernel    
    nn = size(Xc, 2);
    try
        kh = KH(Xc-xc(:, 1:nn), H, sigma);
    catch
        dbstack(); rethrow(lasterror);
    end              

    % Adjusting step size with curvature
    if nr > 0
        v = v * exp(abs(r_set(:, end)'*r) - 1);
    end

    
    % Pushing circle forward
    try
        u = LCOM(Xc, kh);
        sigmas = LCM(Xc, u, kh);
        [COEFF LATENT EXPLAINED] = pcacov(sigmas);
    catch
        save lpc; dbstack(); rethrow(lasterror);
    end
    u = u + [nL-1; mL-1];
    
    r(:, 1) = nextstep(r(:, 1), COEFF(:, 1), 1);
    r(:, 1) = (r(:, 1).*rs)/norm(r(:, 1).*rs);
    x = u + v * r; 
    
    % Storing results
    r_set = [r_set r];        
    w_set = [w_set EXPLAINED(2)];
    u_set = [u_set u];
    h_set = [h_set h];
    
    if disp
        cc = cc + 1;
        figure(1),
        plot(u(1), u(2), 'b.', 'MarkerSize', ceil(h0/4)),
        plot([u(1) x(1)], [u(2) x(2)], 'b-', 'LineWidth', ceil(h0/10)),
        drawnow
    end
end
h_set(1) = []; 
return