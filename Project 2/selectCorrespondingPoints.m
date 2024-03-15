function [floor_x1, floor_y1, floor_x2, floor_y2] = selectCorrespondingPoints(image1, image2, numPoints)
    % Initialize arrays to store selected points
    floor_x1 = zeros(numPoints, 1);
    floor_y1 = zeros(numPoints, 1);
    floor_x2 = zeros(numPoints, 1);
    floor_y2 = zeros(numPoints, 1);
    
    for i = 1:numPoints
        % Display the first image and select a point
        figure; imshow(image1); title(['Select point #' num2str(i) ' on the floor in the first image']);
        [x, y] = ginput(1);  % Wait for one point to be selected
        floor_x1(i) = x;
        floor_y1(i) = y;
        close;  % Close the figure window
        
        % Display the second image and select the corresponding point
        figure; imshow(image2); title(['Select the corresponding point for point #' num2str(i) ' in the second image']);
        [x, y] = ginput(1);  % Wait for one point to be selected
        floor_x2(i) = x;
        floor_y2(i) = y;
        close;  % Close the figure window
    end
end
