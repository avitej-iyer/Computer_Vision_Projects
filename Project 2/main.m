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
figure; imshow(imread("im1corrected.jpg")); hold on; plot(p1_projection(1, :), p1_projection(2, :), 'ro');
figure; imshow(imread("im2corrected.jpg")); hold on; plot(p2_projection(1, :), p2_projection(2, :), 'ro');

% Triangulation to recover 3D points and error checking
recovered_points = triangulatePoints(p1_projection, p2_projection, V1_Params, V2_Params);
mse = computeMSE(pts3D, recovered_points);