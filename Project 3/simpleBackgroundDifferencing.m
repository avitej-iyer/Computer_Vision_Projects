function outputFrames = new_simpleBackgroundDifferencing(grayImages, lambda)
    % Validate lambda
    if lambda < 0 || lambda > 255
        error('Lambda must be between 0 and 255.');
    end
    
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
        
        % Compute the absolute difference
        diffFrame = abs(currentFrame - background);
        
        % Apply threshold to convert differences to binary values
        % Pixels with differences greater than lambda become 1, else 0
        motionMask = diffFrame > lambda;
        
        % Store the binary motion mask in the output array
        outputFrames{i} = motionMask;
    end
end
