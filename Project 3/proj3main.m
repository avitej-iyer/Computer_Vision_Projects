function proj3main(dirstring, maxframenum, abs_diff_threshold, alpha_parameter, gamma_parameter)

% Define the folder containing the video frames
% change folder path to convert other video to grayscale
folderPath = dirstring;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Step 1
grayscale_ants = convertToGrayScale(folderPath);
grayscale_ants = grayscale_ants(1:maxframenum);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Step 2


new_simple_back_sub_out = simpleBackgroundDifferencing(grayscale_ants, abs_diff_threshold);

new_simple_frame_diff_out = simpleFrameDifferencing(grayscale_ants, abs_diff_threshold);

new_adaptive_background_sub_out = adaptiveBackgroundSubtraction(grayscale_ants, alpha_parameter, abs_diff_threshold);

new_persistent_frame_diff_out = persistentFrameDifferencing(grayscale_ants, abs_diff_threshold, gamma_parameter);


quad_panel = createQuadPanelImages(new_simple_back_sub_out, new_simple_frame_diff_out, new_adaptive_background_sub_out, new_persistent_frame_diff_out);

%saveOutputFrames(new_persistent_frame_diff_out, 'ants_output_quad');

createVideoFromImageArray(quad_panel, 15, 'video_outputs\', 'new_generated_video');

end

