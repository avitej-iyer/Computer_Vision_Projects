function returning_2d_points = projectAndVisualize(pts3D, Parameters)
    % Extract the intrinsic matrix (K) and the rotation matrix (R) from Parameters
    K = Parameters.Kmat;
    R = Parameters.Rmat;
    
    % The position vector needs to be converted to a translation vector
    t = -R * Parameters.position';

    % Construct the extrinsic parameter matrix
    extrinsicMat = [R, t];
    
    % Construct the full projection matrix
    P = K * extrinsicMat;
    
    % Convert 3D points to homogeneous coordinates
    pts3D_homogeneous = [pts3D; ones(1, size(pts3D, 2))];
    
    % Project 3D points to 2D using the projection matrix
    pts2D_homogeneous = P * pts3D_homogeneous;
    
    % Convert back to Cartesian coordinates
    returning_2d_points = pts2D_homogeneous(1:2, :) ./ pts2D_homogeneous(3, :);
    
    % Junk code for debugging
    %{
    img = imread(imageFile);
    imshow(img);
    hold on;
    
    plot(pts2D(1, :), pts2D(2, :), 'ro', 'MarkerSize', 5, 'LineWidth', 1.5);
    title('Projected 2D Points on Image');
    hold off;
    %}
end