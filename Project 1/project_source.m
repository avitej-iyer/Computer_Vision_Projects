[filename,gaussian_sd,size_of_neighbourhood,radius_of_neighbourhood,number_corners] = read_corner_parameters('cornerparams.dat');

% IMPORTANT
% ADD A WAY TO SWITCH BETWEEN IMAGES LATER
grayscale_image = convert_to_grayscale('psutd.jpg');

smooth = smooth_image(grayscale_image, gaussian_sd);

[grad_x,grad_y] = compute_gradients(smooth);

% declaration for harris value calculation
k = 0.05;
corner_values = harris_corner_detection(grad_x,grad_y, size_of_neighbourhood, k);


corners = extract_best_corners(corner_values, number_corners, radius_of_neighbourhood);

visualize_corners(grayscale_image, corners);

