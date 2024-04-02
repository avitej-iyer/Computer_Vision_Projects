function grayImages = convertToGrayScale(folderPath)
    % Get a list of all image files in the folder
    imageFiles = dir(fullfile(folderPath, '*.jpg'));
    
    % Initialize array to store grayscale images
    grayImages = cell(1, numel(imageFiles));
    
    % Loop through each image file
    for i = 1:numel(imageFiles)
        % Read the current image
        img = imread(fullfile(folderPath, imageFiles(i).name));
        
        % Convert the image to grayscale
        grayImg = rgb2gray(img);
        
        % Store the grayscale image in the array
        grayImages{i} = grayImg;
    end
end
