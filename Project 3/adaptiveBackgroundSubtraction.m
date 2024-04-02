function outputFrames = adaptiveBackgroundSubtraction(grayImages, alpha)
    % Number of frames
    numFrames = length(grayImages);
    
    % Convert the first frame to double to initialize the background model
    background = double(grayImages{1});
    
    % Preallocate the output array
    outputFrames = cell(1, numFrames);
    
    % Loop over each frame
    for i = 1:numFrames
        % Convert the current frame to double for computation
        currentFrame = double(grayImages{i});
        
        % Compute the absolute difference between the current frame and the background model
        diffFrame = abs(currentFrame - background);
        
        % Update the background model
        background = (1 - alpha) * background + alpha * currentFrame;
        
        % Normalize the difference image to be in the range 0-1
        diffFrame = mat2gray(diffFrame);
        
        % Store the result in the output array
        outputFrames{i} = diffFrame;
    end
end
