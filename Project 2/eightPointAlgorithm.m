function F = eightPointAlgorithm(image, image2, savx1, savx2, savy1, savy2, printer, project_step)
    x1 = savx1; y1 = savy1; x2 = savx2; y2 = savy2;

    if ischar(image) 
        im = imread(image);
        im2 = imread(image2);
    else
        im = image;
        im2 = image2;
    end

    if eq(printer, 1)
        figure(60); imagesc(im); axis image; drawnow;
        figure(61); imagesc(im2); axis image; drawnow;
        
    
    

        %figure(60); [x1,y1] = getpts;
        figure(60); imagesc(im); axis image; hold on
        for i=1:length(x1)
           h=plot(x1(i),y1(i),'*'); set(h,'Color','g','LineWidth',2);
           text(x1(i),y1(i),sprintf('%d',i));
        end
        hold off
        drawnow;
        
        
        %figure(61); imagesc(im2); axis image; drawnow;
        %[x2,y2] = getpts;
        figure(61); imagesc(im2); axis image; hold on
        for i=1:length(x2)
           h=plot(x2(i),y2(i),'*'); set(h,'Color','g','LineWidth',2);
           text(x2(i),y2(i),sprintf('%d',i));
        end
        hold off
        drawnow
    
    end
    
    %do Hartley preconditioning
    %savx1 = x1; savy1 = y1; savx2 = x2; savy2 = y2;
    mux = mean(x1);
    muy = mean(y1);
    stdxy = (std(x1)+std(y1))/2;
    T1 = [1 0 -mux; 0 1 -muy; 0 0 stdxy]/stdxy;
    nx1 = (x1-mux)/stdxy;
    ny1 = (y1-muy)/stdxy;
    mux = mean(x2);
    muy = mean(y2);
    stdxy = (std(x2)+std(y2))/2;
    T2 = [1 0 -mux; 0 1 -muy; 0 0 stdxy]/stdxy;
    nx2 = (x2-mux)/stdxy;
    ny2 = (y2-muy)/stdxy;
    
    A = [];
    for i=1:length(nx1);
        A(i,:) = [nx1(i)*nx2(i) nx1(i)*ny2(i) nx1(i) ny1(i)*nx2(i) ny1(i)*ny2(i) ny1(i) nx2(i) ny2(i) 1];
    end
    %get eigenvector associated with smallest eigenvalue of A' * A
    [u,d] = eigs(A' * A,1,'SM');
    F = reshape(u,3,3);
    
    %make F rank 2
    oldF = F;
    [U,D,V] = svd(F);
    D(3,3) = 0;
    F = U * D * V';
    
    %unnormalize F to undo the effects of Hartley preconditioning
    F = T2' * F * T1;

    if eq(printer, 1)
    
        colors =  'bgrcmykbgrcmykbgrcmykbgrcmykbgrcmykbgrcmykbgrcmyk';
        %overlay epipolar lines on im2
        L = F * [x1' ; y1'; ones(size(x1'))];
        [nr,nc,nb] = size(im2);
        figure(61); clf; imagesc(im2); axis image; title("8 Point F matrix Projection for Step 5 - Image 2"); 
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
        figure(60); clf; imagesc(im); axis image; title("8 Point F matrix Projection for Step 5 - Image 1"); 
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
    end
end
%     this prints out the calculated fundamental matrix
%     for j=1:3
%         for i=1:3
%             fprintf('%10g ',10000*F(j,i));
%         end
%         fprintf('\n');
%     end
