function distance = selectPointAndMeasureDistance(image1, image2, Parameters_1, Parameters_2, plane, object)
    % Manually select a point in the first image
    figure; imshow(image1); title(strcat('Select a point in the first image for ', object));
    [floor_x1, floor_y1] = ginput(1);  % Wait for one point to be selected
    close;  % Close the figure window

    % Manually select the corresponding point in the second image
    figure; imshow(image2); title(strcat('Select the corresponding point in the second image for ', object));
    [floor_x2, floor_y2] = ginput(1);  % Wait for one point to be selected
    close;  % Close the figure window

    % Triangulate to find the 3D point
    % Assuming triangulatePoints function is already defined and available
    pts2D_1 = [floor_x1; floor_y1];
    pts2D_2 = [floor_x2; floor_y2];
    [P3D] = triangulatePoints(pts2D_1, pts2D_2, Parameters_1, Parameters_2);

    % Calculate the distance from the plane to the 3D point
    A = plane(1); B = plane(2); C = plane(3); D = plane(4);
    distance = abs(A * P3D(1) + B * P3D(2) + C * P3D(3) + D) / sqrt(A^2 + B^2 + C^2);
end
