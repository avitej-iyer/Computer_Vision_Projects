function drawEpipolarLines(image1, image2, F, x1, x2, y1, y2)
   colors =  'bgrcmykbgrcmykbgrcmykbgrcmykbgrcmykbgrcmykbgrcmyk';
    
   if isstring(image1)
    im = imread(image1);
    im2 = imread(image2);
   else
    im = image1;
    im2 = image2;
   end

   
    %overlay epipolar lines on im2
    L = F * [x1' ; y1'; ones(size(x1'))];
    [nr,nc,nb] = size(im2);
    figure(71); clf; imagesc(im2); axis image; title("Epipolar lines on cropped image from picture 2 (Extra Credit)");
    hold on; plot(x2,y2,'*'); hold off
    for i=1:length(L)
        a = L(1,i); b = L(2,i); c=L(3,i);
        if (abs(a) > (abs(b)))
           ylo=0; yhi=nr; 
           xlo = (-b * ylo - c) / a;
           xhi = (-b * yhi - c) / a;
           hold on
           h=plot([xlo; xhi],[ylo; yhi]);
           set(h,'Color',colors(i),'LineWidth',2);
           hold off
           drawnow;
        else
           xlo=0; xhi=nc; 
           ylo = (-a * xlo - c) / b;
           yhi = (-a * xhi - c) / b;
           hold on
           h=plot([xlo; xhi],[ylo; yhi],'b');
           set(h,'Color',colors(i),'LineWidth',2);
           hold off
           drawnow;
        end
    end
    
    
    %overlay epipolar lines on im1
    L = ([x2' ; y2'; ones(size(x2'))]' * F)' ;
    [nr,nc,nb] = size(im);
    figure(70); clf; imagesc(im); axis image;title("Epipolar lines on cropped image from picture 1 (Extra Credit)");
    hold on; plot(x1,y1,'*'); hold off
    for i=1:length(L)
        a = L(1,i); b = L(2,i); c=L(3,i);
        if (abs(a) > (abs(b)))
           ylo=0; yhi=nr; 
           xlo = (-b * ylo - c) / a;
           xhi = (-b * yhi - c) / a;
           hold on
           h=plot([xlo; xhi],[ylo; yhi],'b');
           set(h,'Color',colors(i),'LineWidth',2);
           hold off
           drawnow;
        else
           xlo=0; xhi=nc; 
           ylo = (-a * xlo - c) / b;
           yhi = (-a * xhi - c) / b;
           hold on
           h=plot([xlo; xhi],[ylo; yhi],'b');
           set(h,'Color',colors(i),'LineWidth',2);
           hold off
           drawnow;
        end
    end
    
    
    for j=1:3
        for i=1:3
            fprintf('%10g ',10000*F(j,i));
        end
        fprintf('\n');
    end
end