function drawEpipolarLines(im1, im2, F)
   % Display the first image for point selection
    figure; imshow(im1); title('Select points on this image and press Enter when done');
    [x1, y1] = ginput; % Allows for multiple points to be selected
    
    % Prepare to draw epipolar lines on the second image
    figure; imshow(im2); title('Epipolar lines in the second image');
    hold on;
    
    % Iterate over each selected point to draw its epipolar line on the second image
    for i = 1:length(x1)
        % Construct the point in homogeneous coordinates
        point = [x1(i); y1(i); 1];
        
        % Compute the corresponding epipolar line in the second image
        epipolarLine = F * point;
        
        % Define the line function ax + by + c = 0
        a = epipolarLine(1);
        b = epipolarLine(2);
        c = epipolarLine(3);
        
        % Compute the intersection points of the epipolar line with the image borders
        xPoints = [1, size(im2, 2)]; % Horizontal span of the image
        yPoints = [(-c - a*xPoints(1)) / b, (-c - a*xPoints(2)) / b]; % Corresponding y values based on the line equation
        
        % Draw the epipolar line
        plot(xPoints, yPoints, 'g-', 'LineWidth', 1);
    end
    hold off;
end