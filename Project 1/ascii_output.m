function ascii_output(corners, R, filename)
    % Open the file for writing
    fileID = fopen(filename, 'w');

    % Write a comment/header (optional)
    fprintf(fileID, '%% file format for corner detection project output\n');
    fprintf(fileID, '%% Rvalue Column_location Row_location\n');

    % Write the number of corners found
    fprintf(fileID, '%d\n', size(corners, 1));

    % Iterate through each corner and write the R value, column, and row locations
    for i = 1:size(corners, 1)
        row = corners(i, 1);
        col = corners(i, 2);
        Rvalue = R(row, col);  % Assuming R is accessible and contains Harris R values

        % Write the R value and corner location to the file
        fprintf(fileID, '%f %d %d\n', Rvalue, col, row);
    end

    % Close the file
    fclose(fileID);
end
