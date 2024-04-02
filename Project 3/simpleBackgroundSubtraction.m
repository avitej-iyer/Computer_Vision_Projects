function outputFrames = simpleBackgroundSubtraction(grayImages)
    % Assume the first image is the background
    background = double(grayImages{1});
    
    % Number of frames
    numFrames = length(grayImages);
    
    % Preallocate the output array
    outputFrames = cell(1, numFrames);
    
    % Loop over each frame
    for i = 1:numFrames
        % Convert current frame to double for computation
        currentFrame = double(grayImages{i});
        
        % Simple background subtraction
        diffFrame = abs(currentFrame - background);
        
        % Normalize the output to be in the range 0-1
        diffFrame = mat2gray(diffFrame);
        
        % Store the result in the output array
        outputFrames{i} = diffFrame;
    end
end
