function outputFrames = new_persistentFrameDifferencing(grayImages, lambda, gamma)
    % Validate gamma and lambda
    if gamma < 0 || gamma > 255
        error('Gamma must be between 0 and 255.');
    end
    if lambda < 0 || lambda > 255
        error('Lambda must be between 0 and 255.');
    end

    % Initialize the first background frame and the history image
    firstFrame = grayImages{1};
    background = double(firstFrame);
    historyImage = zeros(size(background)); % Initially set to zero
    
    % Number of frames
    numFrames = length(grayImages);
    
    % Preallocate the output array and set the first frame to completely black
    outputFrames = cell(1, numFrames);
    outputFrames{1} = zeros(size(firstFrame)); % First output frame is completely black
    
    % Loop over each frame starting from the second frame
    for i = 2:numFrames
        % Convert current frame to double for computation
        currentFrame = double(grayImages{i});
        
        % Compute the absolute difference with the previous background
        diffFrame = abs(background - currentFrame);
        
        % Apply threshold to convert differences to binary values
        motionMask = diffFrame > lambda;
        
        % Decay the history image and update it with the current motion mask
        historyImage = max(historyImage - gamma, 0);
        historyImage = max(255 * double(motionMask), historyImage);
        
        % Normalize the history image to the range [0, 1] for consistent output
        normalizedHistory = mat2gray(historyImage);
        
        % Store the normalized history image in the output array
        outputFrames{i} = normalizedHistory;
        
        % Update the background model to the current frame
        background = currentFrame;
    end
end
