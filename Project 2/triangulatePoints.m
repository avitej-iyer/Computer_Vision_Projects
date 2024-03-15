% Step 2

function [recoveredPts3D] = triangulatePoints(pts2D_1, pts2D_2, Parameters_1, Parameters_2)
    % Initialize the array to hold recovered 3D points
    recoveredPts3D = zeros(3, size(pts2D_1, 2));
    
    % Iterate through each pair of 2D points
    for i = 1:size(pts2D_1, 2)
        % Extract the i-th pair of 2D points
        p1 = pts2D_1(:, i);
        p2 = pts2D_2(:, i);
        
        % Camera 1 parameters
        K1 = Parameters_1.Kmat;
        R1 = Parameters_1.Rmat;
        t1 = -R1 * Parameters_1.position';
        
        % Camera 2 parameters
        K2 = Parameters_2.Kmat;
        R2 = Parameters_2.Rmat;
        t2 = -R2 * Parameters_2.position';
        
        % Convert the 2D points to normalized camera coordinates
        p1_cam = inv(K1) * [p1; 1];
        p2_cam = inv(K2) * [p2; 1];
        
        % Ray directions in world coordinates
        D1 = R1' * p1_cam(1:3);
        D2 = R2' * p2_cam(1:3);
        
        % Camera centers in world coordinates
        O1 = -R1' * t1;
        O2 = -R2' * t2;
        
        % Set up the system of equations A*X = B
        A = [D1, -D2];
        B = O2 - O1;
        
        % Solve the least squares problem for the closest points on the rays
        X = A \ B;  % Equivalent to inv(A'*A)*(A')*B in a least squares sense
        
        % Calculate the 3D point as the midpoint between the closest points on the rays
        point3D = (O1 + D1 * X(1) + O2 + D2 * X(2)) / 2;
        
        % Store the recovered 3D point
        recoveredPts3D(:, i) = point3D;
    end
end
