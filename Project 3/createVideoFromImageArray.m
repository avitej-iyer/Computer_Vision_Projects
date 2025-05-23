function createVideoFromImageArray(imageFiles, frameRate, outputDir, dirstring)
    % Check if output directory exists, if not, create it
    if ~exist(outputDir, 'dir')
        mkdir(outputDir);
    end

    % Use the name of the original dataset as the output video file name
    outputFileName = append(string(extractBetween(dirstring, 10, strlength(dirstring) - 1)), ' Output' );

    % Full path for the output video file
    outputFileFullPath = fullfile(outputDir, outputFileName);

    % Create a VideoWriter object to write video file
    videoWriterObj = VideoWriter(outputFileFullPath, 'MPEG-4'); % You can choose other formats as well
    videoWriterObj.FrameRate = frameRate;

    % Open the VideoWriter object to start writing video
    open(videoWriterObj);

    % Loop through each image in the image array
    for idx = 1:length(imageFiles)
        % Read the image
        img = imageFiles{idx};

        % Write the image frame to the video
        writeVideo(videoWriterObj, img);
    end

    % Close the VideoWriter object
    close(videoWriterObj);

    disp(['Video saved to ', outputFileFullPath]);
end
