function outputImages = createQuadPanelImages(array1, array2, array3, array4)
    numImages = length(array1);
    outputImages = cell(1, numImages);
    
    % Loop over each set of images
    for i = 1:numImages
        % Extract the i-th image from each input array
        img1 = array1{i};
        img2 = array2{i};
        img3 = array3{i};
        img4 = array4{i};
        
        % Concatenate images in a 2x2 grid
        topRow = cat(2, img1, img2); % Concatenate horizontally
        bottomRow = cat(2, img3, img4); % Concatenate horizontally
        
        % Concatenate the two rows vertically to form the quad panel
        quadPanel = cat(1, topRow, bottomRow);
        
        % Store the quad panel in the output array
        outputImages{i} = quadPanel;
    end
end
