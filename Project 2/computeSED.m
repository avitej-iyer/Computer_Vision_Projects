function SED = computeSED(F, p1_projection, p2_projection)
    % Ensure points are in homogeneous coordinates
    points1_homogeneous = [p1_projection; ones(1, size(p1_projection, 2))];
    points2_homogeneous = [p2_projection; ones(1, size(p2_projection, 2))];

    % Initialize the sum of squared distances
    sumSquaredDistances = 0;
    
    % Iterate over all matched point pairs
    for i = 1:size(points1_homogeneous, 2)
        % Get the i-th points in homogeneous coordinates
        x1 = points1_homogeneous(:, i);
        x2 = points2_homogeneous(:, i);
        
        % Compute epipolar lines
        l2 = F * x1;  % Epipolar line in image 2 for the point in image 1
        l1 = F' * x2;  % Epipolar line in image 1 for the point in image 2
        
        % Compute squared distances from points to their corresponding epipolar lines
        distSquared1 = (l1' * x1)^2 / (l1(1)^2 + l1(2)^2);
        distSquared2 = (l2' * x2)^2 / (l2(1)^2 + l2(2)^2);
        
        % Accumulate the squared distances
        sumSquaredDistances = sumSquaredDistances + distSquared1 + distSquared2;
    end
    
    % Compute the mean of the accumulated squared distances
    SED = sumSquaredDistances / (2 * size(points1_homogeneous, 2));  % Divided by 2 * number of pairs
end
