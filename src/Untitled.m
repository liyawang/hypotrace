close all
dr = 'C:\Documents and Settings\Administrator\Desktop\Etiol Cam3 070314';
d = dir(dr);

mov = avifile('hypo10', 'compression', 'xvid');
try
    for i=3: 3:length(d)-40
        im = imread(strcat(dr, '\', d(i).name));

        if i==3
            imshow(im); drawnow
            [xmin ymin width height] = checkRect(im);
            im = im(ymin:ymin+height, xmin:xmin+width);
            close all, imshow(im); drawnow
        else
            im = im(ymin:ymin+height, xmin:xmin+width);
            imshow(im); drawnow
        end
        F = getframe(gcf);
        mov = addframe(mov,F);
        mov = close(mov);
    end
catch
    mov = close(mov);
end