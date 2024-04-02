function outputFrames = simpleFrameDifferencing(grayImages)
    % Number of frames
    numFrames = length(grayImages);
    
    % Preallocate the output array
    outputFrames = cell(1, numFrames);
    
    % Loop over each frame, starting from the second one
    for i = 2:numFrames
        % Convert the current and previous frames to double for computation
        currentFrame = double(grayImages{i});
        previousFrame = double(grayImages{i-1});
        
        % Compute the difference between the current and the previous frame
        diffFrame = abs(currentFrame - previousFrame);
        
        % Normalize the output to be in the range 0-1
        diffFrame = mat2gray(diffFrame);
        
        % Store the result in the output array
        outputFrames{i} = diffFrame;
    end
    
    % For the first frame, we can't compute the difference, so we might just copy it as is,
    % or set it to a blank frame (all zeros). Here, we choose a blank frame.
    outputFrames{1} = zeros(size(grayImages{1}));
end
