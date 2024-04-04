function outputFrames = new_adaptiveBackgroundSubtraction(grayImages, alpha, lambda)
    % Validate alpha and lambda
    if alpha < 0 || alpha > 1
        error('Alpha must be between 0 and 1.');
    end
    if lambda < 0 || lambda > 255
        error('Lambda must be between 0 and 255.');
    end
    
    % Number of frames
    numFrames = length(grayImages);
    
    % Preallocate the output array and set the first frame to completely black
    firstFrame = grayImages{1};
    outputFrames = cell(1, numFrames);
    outputFrames{1} = zeros(size(firstFrame)); % First output frame is completely black
    
    % Initialize the background to the first frame
    background = double(firstFrame);
    
    % Loop over each frame starting from the second frame
    for i = 2:numFrames
        % Convert current frame to double for computation
        currentFrame = double(grayImages{i});
        
        % Compute the absolute difference with the current background
        diffFrame = abs(background - currentFrame);
        
        % Apply threshold to convert differences to binary values
        motionMask = diffFrame > lambda;
        
        % Store the binary motion mask in the output array
        outputFrames{i} = motionMask;
        
        % Update the background model
        background = alpha * currentFrame + (1 - alpha) * background;
    end
end
