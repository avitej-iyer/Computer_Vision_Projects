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

% Step 2
% Triangulation to recover 3D points and error checking 
recovered_points = triangulatePoints(p1_projection, p2_projection, V1_Params, V2_Params);
mse = computeMSE(pts3D, recovered_points);

%[floor_x1, floor_y1, floor_x2, floor_y2] = selectCorrespondingPoints('im1corrected.jpg', 'im2corrected.jpg', 4);

% floor points selected by trial and error (mostly error)
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

[floor_plane, floor_normal, floor_point] = fitPlaneToPoints(floorPoints3D);

%[wall_x1, wall_y1, wall_x2, wall_y2] = selectCorrespondingPoints('im1corrected.jpg', 'im2corrected.jpg', 4);

wall_x1 = [1.270250000000000e+03;1.151750000000000e+03;1.744250000000000e+03;1.331750000000000e+03];
wall_x2 = [3.522500000000001e+02;1.587500000000001e+02;8.442500000000001e+02;4.317500000000001e+02];
wall_y1 = [2.892499999999999e+02;2.727499999999999e+02;4.992499999999999e+02;2.382499999999998e+02];
wall_y2 = [1.767499999999998e+02;1.512499999999998e+02;3.597499999999999e+02;1.182499999999998e+02];

wallPoints3D = zeros(3, length(wall_x1));

for i = 1:length(wall_x1)
    p1 = [wall_x1(i), wall_y1(i)];
    p2 = [wall_x2(i), wall_y2(i)];
    
    % Assuming you have the camera parameters yloaded as Parameters_1 and Parameters_2
    wallPoints3D(:, i) = triangulatePoints(p1', p2', V1_Params, V2_Params);
end

[wall_plane, wall_normal, wall_point] = fitPlaneToPoints(wallPoints3D);

height_of_door = selectPointAndMeasureDistance('im1corrected.jpg', 'im2corrected.jpg', V1_Params, V2_Params, floor_plane, "door");
% height of door reference (first calculation) = 2165mm
% height_of_man = selectPointAndMeasureDistance('im1corrected.jpg', 'im2corrected.jpg', V1_Params, V2_Params, floor_plane, "man");
% height of man reference (first calculation) = 1640mm

% figuring out the camera's 3d position 
% first run gives the position
% [-142;-4945;2351];
%{
[camera_x1,camera_y1, camera_x2, camera_y2] = selectCorrespondingPoints('im1corrected.jpg', 'im2corrected.jpg', 1);
cameraPoint3D = zeros(3, length(camera_x1));

% Loop through each point and triangulate
for i = 1:length(camera_x1)
    p1 = [camera_x1(i), camera_y1(i)];
    p2 = [camera_x2(i), camera_y2(i)];
    
    % Assuming you have the camera parameters loaded as Parameters_1 and Parameters_2
    cameraPoint3D(:, i) = triangulatePoints(p1', p2', V1_Params, V2_Params);
end
%}

% STEP 3 RESULTS
% FLOOR PLANE = [-0.007607656322775;-0.012493811339910;0.999893008398137;7.506050164140770]
% WALL PLANE = [0.007141510079416;0.999973914830431;0.001080968310346;5.541614733911812e+03]
% HEIGHT OF DOOR = 2165mm
% HEIGHT OF MAN = 1640mm
% CAMERA'S 3D POSITION (NEAR THE STRIPED WALL) = [-142;-4945;2351]



