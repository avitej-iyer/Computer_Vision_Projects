function outputFrames = persistentFrameDifferencing(grayImages, thresholdValue, g)
    % Number of frames
    numFrames = length(grayImages);
    
    % Initialize the background with the first frame and the history image with zeros
    B = double(grayImages{1});
    H = zeros(size(B));
    
    % Preallocate the output array
    outputFrames = cell(1, numFrames);
    
    % Loop over each frame
    for t = 1:numFrames
        % Current frame
        I = double(grayImages{t});
        
        % Compute the absolute difference
        diff = abs(B - I);
        
        % Motion mask based on the threshold
        M = diff > thresholdValue;
        
        % Update the history image
        tmp = max(H-g, 0);
        H = max(255*M, tmp);
        
        % Normalize H to be in the range 0-1 for consistency with other methods
        H_normalized = H / 255;
        
        % Store the result in the output array
        outputFrames{t} = H_normalized;
        
        % Update the background for the next iteration
        B = I;
    end
end
