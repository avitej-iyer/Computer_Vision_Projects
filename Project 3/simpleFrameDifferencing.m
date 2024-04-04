function outputFrames = new_simpleFrameDifferencing(grayImages, lambda)
    % Validate lambda
    if lambda < 0 || lambda > 255
        error('Lambda must be between 0 and 255.');
    end
    
    % Number of frames
    numFrames = length(grayImages);
    
    % Preallocate the output array with the same dimensions as the input images
    % Initialize the first frame to a black image
    firstFrame = grayImages{1};
    outputFrames = cell(1, numFrames);
    outputFrames{1} = zeros(size(firstFrame)); % First output frame is completely black
    
    % Initialize the previous frame to the first frame for comparison
    prevFrame = double(firstFrame);
    
    % Loop over each frame starting from the second frame
    for i = 2:numFrames
        % Convert current frame to double for computation
        currentFrame = double(grayImages{i});
        
        % Compute the absolute difference with the previous frame
        diffFrame = abs(prevFrame - currentFrame);
        
        % Apply threshold to convert differences to binary values
        motionMask = diffFrame > lambda;
        
        % Store the binary motion mask in the output array
        outputFrames{i} = motionMask;
        
        % Update the previous frame to the current one for the next iteration
        prevFrame = currentFrame;
    end
end
