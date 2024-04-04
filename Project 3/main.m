% Define the folder containing the video frames
% change folder path to convert other video to grayscale
folderPath = 'DataSets\AAnts\';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Step 1
grayscale_ants = convertToGrayScale(folderPath);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Step 2

lambda = 90;
new_simple_back_sub_out = new_simpleBackgroundDifferencing(grayscale_ants, lambda);

lambda = 40;
new_simple_frame_diff_out = new_simpleFrameDifferencing(grayscale_ants, lambda);

lambda = 40;
alpha = 0.1;
new_adaptive_background_sub_out = new_adaptiveBackgroundSubtraction(grayscale_ants, alpha, lambda);

lambda = 40;
gamma = 50;
new_persistent_frame_diff_out = new_persistentFrameDifferencing(grayscale_ants, lambda, gamma);


quad_panel_ants = createQuadPanelImages(new_simple_back_sub_out, new_simple_frame_diff_out, new_adaptive_background_sub_out, new_persistent_frame_diff_out);

%saveOutputFrames(new_persistent_frame_diff_out, 'ants_output_quad');

createVideoFromImageArray(quad_panel_ants, 15, 'video_outputs\', 'new_ants_vid_back_sub');
