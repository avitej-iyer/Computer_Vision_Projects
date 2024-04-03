function framesToVideo(inputDir, frameRate, outputDir)
    % Check if the output directory exists, if not, create it
    if ~exist(outputDir, 'dir')
        mkdir(outputDir);
    end

    % Define the video file name and path
    outputVideoPath = fullfile(outputDir, 'outputVideo.avi');

    % Create a video writer object
    videoWriter = VideoWriter(outputVideoPath);
    videoWriter.FrameRate = frameRate;

    % Open the video writer
    open(videoWriter);

    % Get a list of all JPEG files in the input directory
    files = dir(fullfile(inputDir, '*.jpg'));
    % Sort the files by name
    [~, idx] = sort({files.name});
    files = files(idx);

    % Loop through each file and write it to the video
    for i = 1:length(files)
        % Construct the full file path
        filePath = fullfile(inputDir, files(i).name);
        % Read the image
        img = imread(filePath);
        % Write the image frame to the video
        writeVideo(videoWriter, img);
    end

    % Close the video writer
    close(videoWriter);

    disp(['Video saved to: ', outputVideoPath]);
end
