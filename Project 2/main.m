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

floorPoints3D = get3DPointsMatrix(floor_x1, floor_x2, floor_y1, floor_y2, V1_Params, V2_Params);
[floor_plane, floor_normal, floor_point] = fitPlaneToPoints(floorPoints3D);

%[wall_x1, wall_y1, wall_x2, wall_y2] = selectCorrespondingPoints('im1corrected.jpg', 'im2corrected.jpg', 4);

wall_x1 = [1.270250000000000e+03;1.151750000000000e+03;1.744250000000000e+03;1.331750000000000e+03];
wall_x2 = [3.522500000000001e+02;1.587500000000001e+02;8.442500000000001e+02;4.317500000000001e+02];
wall_y1 = [2.892499999999999e+02;2.727499999999999e+02;4.992499999999999e+02;2.382499999999998e+02];
wall_y2 = [1.767499999999998e+02;1.512499999999998e+02;3.597499999999999e+02;1.182499999999998e+02];


wallPoints3D = get3DPointsMatrix(wall_x1, wall_x2, wall_y1, wall_y2, V1_Params, V2_Params);
[wall_plane, wall_normal, wall_point] = fitPlaneToPoints(wallPoints3D);

% height_of_door = selectPointAndMeasureDistance('im1corrected.jpg', 'im2corrected.jpg', V1_Params, V2_Params, floor_plane, "door");
% height of door reference (first calculation) = 2165mm
% height_of_man = selectPointAndMeasureDistance('im1corrected.jpg', 'im2corrected.jpg', V1_Params, V2_Params, floor_plane, "man");
% height of man reference (first calculation) = 1640mm

% figuring out the camera's 3d position 
% first run gives the position
% [-142;-4945;2351];
%{
[camera_x1,camera_y1, camera_x2, camera_y2] = selectCorrespondingPoints('im1corrected.jpg', 'im2corrected.jpg', 1);

cameraPoint3D = get3DPointsMatrix(camera_x1, camera_x2, camera_y1, camera_y2, V1_Params, V2_Params);
%}

% STEP 3 RESULTS
% Floor plane = [-0.007607656322775;-0.012493811339910;0.999893008398137;7.506050164140770]
% Wall plane = [0.007141510079416;0.999973914830431;0.001080968310346;5.541614733911812e+03]
% Height of door = 2165mm
% Height of man = 1640mm
% Camera's 3d position (near striped wall) = [-142;-4945;2351]


% THIS DOESN'T WORK
% savx1 = [1.034750000000000e+03,1.577750000000000e+03,9.837500000000002e+02,1.450250000000000e+03,1.430750000000000e+03,1.616750000000000e+03,1.271750000000000e+03,1.328750000000000e+03]';
% savx2 = [1.718750000000000e+03,1.117250000000000e+03,4.977500000000001e+02,7.527500000000001e+02,5.907500000000001e+02,7.647500000000001e+02,3.522500000000001e+02,4.332500000000001e+02]';
% savy1 = [9.432500000000001e+02,7.197500000000000e+02,6.072500000000000e+02,6.237500000000000e+02,5.907499999999999e+02,6.192500000000000e+02,2.772499999999999e+02,2.367499999999998e+02]';
% savy2 = [7.032500000000000e+02,5.367500000000000e+02,6.027500000000000e+02,5.067499999999999e+02,4.917499999999999e+02,4.782499999999999e+02,1.617499999999998e+02,1.182499999999998e+02]';
%fundamental_matrix_calculated = computeFundamentalMatrix(V1_Params, V2_Params);
%drawEpipolarLines('im1corrected.jpg', 'im2corrected.jpg', fundamental_matrix_calculated, savx1, savx2, savy1, savy2);

% points to use for 8 point alg
savx1 = [1.034750000000000e+03,1.577750000000000e+03,9.837500000000002e+02,1.450250000000000e+03,1.430750000000000e+03,1.616750000000000e+03,1.271750000000000e+03,1.328750000000000e+03]';
savx2 = [1.718750000000000e+03,1.117250000000000e+03,4.977500000000001e+02,7.527500000000001e+02,5.907500000000001e+02,7.647500000000001e+02,3.522500000000001e+02,4.332500000000001e+02]';
savy1 = [9.432500000000001e+02,7.197500000000000e+02,6.072500000000000e+02,6.237500000000000e+02,5.907499999999999e+02,6.192500000000000e+02,2.772499999999999e+02,2.367499999999998e+02]';
savy2 = [7.032500000000000e+02,5.367500000000000e+02,6.027500000000000e+02,5.067499999999999e+02,4.917499999999999e+02,4.782499999999999e+02,1.617499999999998e+02,1.182499999999998e+02]';

%[test_x1, test_y1, test_x2, test_y2] = selectCorrespondingPoints('im1corrected.jpg', 'im2corrected.jpg', 8);

test_x1 = [7.332500000000001e+02;5.682500000000001e+02;1.036250000000000e+03;1.742750000000000e+03;1.154750000000000e+03;1.537250000000000e+03;1.618250000000000e+03;1.678250000000000e+03];
test_y1 = [7.032500000000000e+02;6.162500000000000e+02;9.447500000000001e+02;5.007499999999999e+02;2.517499999999999e+02;2.427499999999999e+02;6.162500000000000e+02;1.137499999999998e+02];
test_x2 = [9.687500000000002e+02;2.922500000000001e+02;1.718750000000000e+03;8.457500000000001e+02;1.572500000000001e+02;7.182500000000001e+02;7.632500000000001e+02;7.662500000000001e+02];
test_y2 = [7.287500000000000e+02;7.827500000000000e+02;7.047500000000000e+02;3.612499999999998e+02;1.182499999999998e+02;1.407499999999998e+02;4.752499999999999e+02;32.749999999999770];

fundamental_matrix_eight_point = eightPointAlgorithm('im1corrected.jpg', 'im2corrected.jpg', savx1, savx2, savy1, savy2);
%fundamental_matrix_eight_point = eightPointAlgorithm('im1corrected.jpg', 'im2corrected.jpg', test_x1, test_x2, test_y1, test_y2);
fundamental_matrix_calculated = computeFundamentalMatrix(V1_Params, V2_Params);

%drawEpipolarLines('im1corrected.jpg', 'im2corrected.jpg', fundamental_matrix_calculated, savx1, savx2, savy1, savy2);
SED_eight_point = computeSED(p1_projection, p2_projection, fundamental_matrix_eight_point);
SED_calculated = computeSED(p1_projection, p2_projection, fundamental_matrix_calculated);

