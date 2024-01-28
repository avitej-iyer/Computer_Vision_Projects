[filename,gaussian_sd,size_of_neighbourhood,radius_of_neighbourhood,number_corners] = read_corner_parameters('cornerparams.dat');

% IMPORTANT
% ADD A WAY TO SWITCH BETWEEN IMAGES LATER
grayscale_image = convert_to_grayscale('psulion.jpg');

smooth = smooth_image(grayscale_image, gaussian_sd);

[grad_x,grad_y] = compute_gradients(smooth);