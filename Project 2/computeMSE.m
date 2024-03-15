% Subpart for step 2

function mse = computeMSE(originalPts3D, recoveredPts3D)
    % Ensure the points are in the same size/format
    assert(all(size(originalPts3D) == size(recoveredPts3D)), 'The point sets must have the same dimensions.');

    % Compute the squared differences between original and recovered points
    squaredDiffs = (originalPts3D - recoveredPts3D).^2;

    % Sum the squared differences for each point and average over all points
    mse = sum(squaredDiffs(:)) / numel(originalPts3D);
end
