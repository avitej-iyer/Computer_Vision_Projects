% Define the folder containing the video frames
% change folder path to convert other video to grayscale
folderPath = 'DataSets\AAnts\';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Step 1
grayscale_ants = convertToGrayScale(folderPath);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Step 2

simple_background_sub_output = simpleBackgroundSubtraction(grayscale_ants);
simple_frame_diff_output = simpleFrameDifferencing(grayscale_ants);

alpha = 0.5; % halways between simple frame diff and bg subtraction

adaptive_bg_diff_output = adaptiveBackgroundSubtraction(grayscale_ants, alpha);


thresholdValue = 25; 
g = 50;  % Decay constant
persistent_frame_differencing_output = persistentFrameDifferencing(grayscale_ants, thresholdValue, g);

%saveOutputFrames(persistent_frame_differencing_output, 'ants_persistent_frame_diff_out');
