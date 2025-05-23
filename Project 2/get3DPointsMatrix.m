function new_points = get3DPointsMatrix(x1_arr, x2_arr, y1_arr, y2_arr, params_1, params_2)

    % get a 3d point matrix from (x,y) coordinates from two different views
    % and camera parameters
    
    new_points = zeros(3, length(x1_arr));

    for i = 1:length(x1_arr)
    p1 = [x1_arr(i), y1_arr(i)];
    p2 = [x2_arr(i), y2_arr(i)];
    
    new_points(:, i) = triangulatePoints(p1', p2', params_1, params_2);
    end

end

