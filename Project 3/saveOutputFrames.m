function saveOutputFrames(outputFrames, destinationFolder)
    % Check if the destination folder exists, if not, create it
    if ~exist(destinationFolder, 'dir')
        mkdir(destinationFolder);
    end
    
    % Number of frames
    numFrames = length(outputFrames);
    
    % Loop over each frame in the output array
    for i = 1:numFrames
        % Create a filename for the output image
        fileName = sprintf('%04d.jpg', i);
        
        % Full path for the output image
        fullPath = fullfile(destinationFolder, fileName);
        
        % Extract the frame from the cell array
        frame = outputFrames{i};
        
        % Save the frame as an image
        imwrite(frame, fullPath);
    end
end
