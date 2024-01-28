% Step 6 of the algorithm

function corners = extract_best_corners(corner_matrix, M, D)
    % corner_matrix is the Harris corner response matrix
    % M is the number of corners to extract
    % D is the suppression distance

    % Initialize the list of corner features
    corners = zeros(M, 2); % Each row will hold the [row, col] coordinates of a corner

    for i = 1:M
        % Find the maximum corner matrix value and its coordinates
        [max_val, max_index] = max(corner_matrix(:));
        if max_val == 0
            % No more significant corners to process
            corners = corners(1:i-1, :); % Return only the found corners
            break;
        end
        [row, col] = ind2sub(size(corner_matrix), max_index);

        % Store the coordinates of the corner
        corners(i, :) = [row, col];

        % Suppress the nearby values within distance D
        row_min = max(1, row - D);
        row_max = min(size(corner_matrix, 1), row + D);
        col_min = max(1, col - D);
        col_max = min(size(corner_matrix, 2), col + D);

        corner_matrix(row_min:row_max, col_min:col_max) = 0;

        % Set the corner matrix value at the corner location to 0 to avoid
        % repetition/ reselection
        corner_matrix(row, col) = 0;
    end
end
