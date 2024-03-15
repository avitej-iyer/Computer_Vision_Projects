% Load the 3D mocap points
load('mocapPoints3D.mat', 'pts3D');

% Load camera parameters for the first view and project points
load('Parameters_V1.mat');
V1_Params = Parameters;
p1_projection = projectAndVisualize(pts3D, V1_Params);

% Load camera parameters for the second view and project points
load('Parameters_V2.mat', 'Parameters');
V2_Params = Parameters;
p2_projection = projectAndVisualize(pts3D, V2_Params);
 
% Plot points onto images (Step 1)
%figure; imshow(imread("im1corrected.jpg")); hold on; plot(p1_projection(1, :), p1_projection(2, :), 'ro');
%figure; imshow(imread("im2corrected.jpg")); hold on; plot(p2_projection(1, :), p2_projection(2, :), 'ro');

% Triangulation to recover 3D points and error checking
recovered_points = triangulatePoints(p1_projection, p2_projection, V1_Params, V2_Params);
mse = computeMSE(pts3D, recovered_points);

% [floor_x1, floor_y1, floor_x2, floor_y2] = selectCorrespondingPoints('im1corrected.jpg', 'im2corrected.jpg', 4);


floor_x1 = [1.036250000000000e+03;7.302500000000001e+02;1.448750000000000e+03;5.667500000000001e+02];
floor_x2 = [1.718750000000000e+03;9.672500000000002e+02;7.527500000000001e+02;2.922500000000001e+02];
floor_y1 = [9.417500000000001e+02;7.032500000000000e+02;6.252500000000001e+02;6.147500000000000e+02];
floor_y2 = [7.032500000000000e+02;7.302500000000000e+02;5.067499999999999e+02;7.812500000000000e+02];

% Preallocate array for triangulated 3D points
floorPoints3D = zeros(3, length(floor_x1));

% Loop through each point and triangulate
for i = 1:length(floor_x1)
    p1 = [floor_x1(i), floor_y1(i)];
    p2 = [floor_x2(i), floor_y2(i)];
    
    % Assuming you have the camera parameters loaded as Parameters_1 and Parameters_2
    floorPoints3D(:, i) = triangulatePoints(p1', p2', V1_Params, V2_Params);
end

[plane, normal, point] = fitPlaneToPoints(floorPoints3D);



