
function [plane, normal, point] = fitPlaneToPoints(points)
    
    % Subtract mean to improve numerical stability for SVD
    centroid = mean(points, 2);
    pointsCentered = points - centroid;
    
    % SVD
    [~, ~, V] = svd(pointsCentered');
    
    % Plane normal is the last column of V
    normal = V(:, end);
    
    % A point on the plane (use the centroid)
    point = centroid;
    
    % The plane equation coefficients
    plane = [normal; -dot(normal, centroid)];
end
