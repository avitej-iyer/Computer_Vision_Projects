function SED = computeSED(points1, points2, F)
    % points1 and points2 are Nx2 matrices containing corresponding points in image 1 and image 2 respectively
    % F is the 3x3 fundamental matrix
    
    N = size(points1, 1);  % Number of point correspondences
    distancesSquared = zeros(N, 1);  % Initialize distances
    
    for i = 1:N
        % Convert points to homogeneous coordinates
        p1 = [points1(1,i),points1(2,i) 1]';
        p2 = [points2(1,i),points2(2,i) 1]';
        
        % Compute epipolar lines
        l2 = F * p1;  % Line in image 2 corresponding to point in image 1
        l1 = F' * p2;  % Line in image 1 corresponding to point in image 2
        
        % Compute distances of points from their corresponding lines
        %d1 = (l1' * p1)^2 / (l1(1)^2 + l1(2)^2);
        %d2 = (l2' * p2)^2 / (l2(1)^2 + l2(2)^2);
        d1 = ((l1(1)*p1(1) + l1(2) * p1(2) + l1(3))^2) / (l1(1)^2 + l1(2)^2);
        d2 = ((l2(1)*p2(1) + l2(2) * p2(2) + l2(3))^2) / (l2(1)^2 + l2(2)^2);
        
        % Accumulate squared distances
        distancesSquared(i) = d1 + d2;
    end
    
    % Compute mean of the squared distances
    SED = mean(distancesSquared);
end
