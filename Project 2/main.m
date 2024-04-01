% STEP 1

% Load the 3D mocap points
load('mocapPoints3D.mat', 'pts3D');

% Load camera parameters for the first view and project points
load('Parameters_V1.mat');
V1_Params = Parameters;

figure(10);
p1_projection = projectAndVisualize(pts3D, V1_Params, "none","im1corrected.jpg", 1, 1);

% Load camera parameters for the second view and project points
load('Parameters_V2.mat', 'Parameters');
V2_Params = Parameters;
figure(11);
p2_projection = projectAndVisualize(pts3D, V2_Params, "none",'im2corrected.jpg', 1, 2);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% STEP 2

% Triangulation to recover 3D points and error checking 
recovered_points = triangulatePoints(p1_projection, p2_projection, V1_Params, V2_Params);
mse = computeMSE(pts3D, recovered_points);

% Computed MSE = 5.301433965722105e-24

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% STEP 3

%[floor_x1, floor_y1, floor_x2, floor_y2] = selectCorrespondingPoints('im1corrected.jpg', 'im2corrected.jpg', 4);

% floor points selected by trial and error 
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

%[camera_x1,camera_y1, camera_x2, camera_y2] = selectCorrespondingPoints('im1corrected.jpg', 'im2corrected.jpg', 1);

camera_x1 = 1.528250000000000e+03;
camera_x2 = 7.077500000000001e+02;
camera_y1 = 2.607499999999999e+02;
camera_y2 = 1.527499999999998e+02;

cameraPoint3D = get3DPointsMatrix(camera_x1, camera_x2, camera_y1, camera_y2, V1_Params, V2_Params);


% STEP 3 RESULTS
% Floor plane = [-0.007607656322775;-0.012493811339910;0.999893008398137;7.506050164140770]
% Wall plane = [0.007141510079416;0.999973914830431;0.001080968310346;5.541614733911812e+03]
% Height of door = 2165mm
% Height of man = 1640mm
% Camera's 3d position (near striped wall) = [-1.096482929309536e+02;-5.027384449037352e+03;2.353431639711320e+03]

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% STEP 4

F_calculated = computeFundamentalMatrix(V1_Params, V2_Params, "none", "none");

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% STEP 5

% points for 8 point algorithm (selected using "selectCorrespondingPoints.m")
test_x1 = [1.450250000000000e+03;1.537250000000000e+03;1.556750000000000e+03;7.302500000000001e+02;6.357500000000001e+02;7.407500000000001e+02;1.576250000000000e+03;1.034750000000000e+03];
test_x2 = [7.512500000000001e+02;7.047500000000001e+02;7.257500000000001e+02;9.687500000000002e+02;9.792500000000002e+02;1.127750000000000e+03;1.115750000000000e+03;1.715750000000000e+03];
test_y1 = [6.252500000000001e+02;5.997500000000000e+02;4.527500000000000e+02;7.047500000000000e+02;3.612499999999998e+02;5.127499999999999e+02;7.227500000000000e+02;9.417500000000001e+02];
test_y2 = [5.082499999999999e+02;4.767499999999999e+02;3.402499999999999e+02;7.287500000000000e+02;3.027499999999999e+02;4.752499999999999e+02;5.352500000000000e+02;7.047500000000000e+02];

F_eight_point = eightPointAlgorithm('im1corrected.jpg', 'im2corrected.jpg', test_x1, test_x2, test_y1, test_y2, 1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Step 6
SED_eight_point = computeSED(p1_projection, p2_projection, F_eight_point);
SED_calculated = computeSED(p1_projection, p2_projection, F_calculated);

% Step 6 Results
% SED for F from eight point algorithm = 1.535783956391866
% SED for calculated F from step 4 = 4.391377995464045e-26

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Step 7

%[floor_points_x1,floor_points_y1, floor_points_x2, floor_points_y2] = selectCorrespondingPoints('im1corrected.jpg', 'im2corrected.jpg', 4);

floor_points_x1 = [3.927500000000001e+02,1.033250000000000e+03,1.579250000000000e+03,9.882500000000001e+02];
floor_points_y1 = [7.092500000000000e+02,9.417500000000001e+02,7.212500000000000e+02,6.072500000000000e+02];
findTopDownView('im1corrected.jpg', floor_points_x1, floor_points_y1);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EXTRA CREDIT


% figure; imshow('im1corrected.jpg'); title('Select 2 points to form a rectangle');
% [cropping_points_im1_x, cropping_points_im1_y] = ginput(2);

image_1_crop_x = [5.472500000000001e+02;7.632500000000001e+02];
image_1_crop_y = [3.612499999999998e+02;7.197500000000000e+02];

[cropped_im_1, new_K1] = cropAndChangeIntrinsicMatrix('im1corrected.jpg', V1_Params.Kmat, image_1_crop_x, image_1_crop_y);
% figure(1);
% imshow(cropped_im_1);

% figure; imshow('im2corrected.jpg'); title('Select 2 points to form a rectangle');
% [cropping_points_im2_x, cropping_points_im2_y] = ginput(2);

image_2_crop_x = [9.087500000000002e+02;1.141250000000000e+03];
image_2_crop_y = [3.042499999999999e+02;8.112500000000000e+02];

[cropped_im_2, new_K2] = cropAndChangeIntrinsicMatrix('im2corrected.jpg', V2_Params.Kmat, image_2_crop_x, image_2_crop_y);
% figure(2);
% imshow(cropped_im_2);

% SELECTING POINTS FOR PROJECTION ON CROPPED IMAGES
% [cropped_images_x1, cropped_images_y1, cropped_images_x2, cropped_images_y2] = selectCorrespondingPoints(cropped_im_1, cropped_im_2, 8);

extra_credit_F = computeFundamentalMatrix(V1_Params, V2_Params, new_K1, new_K2);

cropped_images_x1 = [185;35.999999999999970;199;217;76.999999999999970;92.999999999999970;66.999999999999970;18.999999999999970];
cropped_images_y1 = [346;3.570000000000001e+02;1.540000000000000e+02;43.999999999999940;77;1.100000000000000e+02;66;307];
cropped_images_x2 = [58;1.160000000000000e+02;2.230000000000001e+02;70.000000000000030;1.270000000000000e+02;1.580000000000001e+02;66;83.000000000000030];
cropped_images_y2 = [4.285000000000001e+02;4.905000000000001e+02;1.705000000000000e+02;48.499999999999940;1.044999999999999e+02;1.415000000000000e+02;95.499999999999940;4.395000000000001e+02];

drawEpipolarLines(cropped_im_1, cropped_im_2, extra_credit_F, cropped_images_x1, cropped_images_x2, cropped_images_y1, cropped_images_y2);
