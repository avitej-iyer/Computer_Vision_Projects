function findTopDownView(source_image, floor_points_2d_x, floor_points_2d_y)
%FINDTOPDOWNVIEW Summary of this function goes here
%   Detailed explanation goes here

source = imread(source_image);
[nr, nc, nb] = size(source);

dest = zeros(nr,nc,nb);

xpts = floor_points_2d_x.';
ypts = floor_points_2d_y.';

xprimes = [0; nc; nc;  0;];
yprimes = [0;  0; nr; nr;];

%compute homography (from im2 to im1 coord system)
p1 = xpts; p2 = ypts;
p3 = xprimes; p4 = yprimes;
vec1 = ones(size(p1,1),1);
vec0 = zeros(size(p1,1),1);
Amat = [p3 p4 vec1 vec0 vec0 vec0 -p1.*p3 -p1.*p4; vec0 vec0 vec0 p3 p4 vec1 -p2.*p3 -p2.*p4];
bvec = [p1; p2];
h = Amat \ bvec;
fprintf(1,'Homography:');
fprintf(1,' %.2f',h); fprintf(1,'\n');

%warp im1 forward into im2 coord system 
[xx,yy] = meshgrid(1:size(dest,2), 1:size(dest,1));
denom = h(7)*xx + h(8)*yy + 1;
hxintrp = (h(1)*xx + h(2)*yy + h(3)) ./ denom;
hyintrp = (h(4)*xx + h(5)*yy + h(6)) ./ denom;
for b = 1:nb
 dest(:,:,b) = interp2(double(source(:,:,b)),hxintrp,hyintrp,'linear')/255.0;
end

%display result
imagesc(dest);

end

