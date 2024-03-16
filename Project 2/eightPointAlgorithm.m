function F = eightPointAlgorithm(im1, im2)
   % Display the first image and allow the user to select points
    figure; imshow(im1); title('Select at least 8 points on this image and press Enter when done');
    [x1, y1] = ginput; % User selects points with the mouse and presses Enter when done
    
    % Display the second image and allow the user to select corresponding points
    figure; imshow(im2); title('Now select the corresponding points on this image and press Enter when done');
    [x2, y2] = ginput; % User selects corresponding points with the mouse and presses Enter when done
    
    % Ensure an equal number of points have been selected in both images
    if length(x1) ~= length(x2) || isempty(x1)
        error('The number of points selected in both images must be equal and at least 8.');
    end
    
    % Normalize points
    [normalizedPoints1, T1] = normalizePoints([x1, y1]);
    [normalizedPoints2, T2] = normalizePoints([x2, y2]);
    
    % Construct the matrix A based on normalized points
    A = [];
    for i = 1:size(normalizedPoints1, 1)
        x1 = normalizedPoints1(i, 1); y1 = normalizedPoints1(i, 2);
        x2 = normalizedPoints2(i, 1); y2 = normalizedPoints2(i, 2);
        A = [A; x2*x1, x2*y1, x2, y2*x1, y2*y1, y2, x1, y1, 1];
    end
    
    % Solve Af=0 using SVD
    [~, ~, V] = svd(A);
    F = reshape(V(:,end), 3, 3)';
    
    % Enforce the rank-2 constraint on F
    [U, S, V] = svd(F);
    S(3,3) = 0;
    F = U * S * V';
    
    % Denormalize F
    F = T2' * F * T1;
    
    % Function to normalize points
    function [normalizedPoints, T] = normalizePoints(points)
        % Calculate the centroid
        centroid = mean(points, 1);
        
        % Calculate the scale factor to make the average distance from the origin sqrt(2)
        distances = sqrt(sum((points - centroid).^2, 2));
        scale = sqrt(2) / mean(distances);
        
        % Construct the transformation matrix
        T = [scale, 0, -scale*centroid(1); 0, scale, -scale*centroid(2); 0, 0, 1];
        
        % Apply the transformation
        normalizedPoints = (T * [points, ones(size(points, 1), 1)]')';
        normalizedPoints = normalizedPoints(:, 1:2);
    end
end