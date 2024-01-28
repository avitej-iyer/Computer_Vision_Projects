% This is step 3 for the algorithm described in the project

function smoothed_image = smooth_image(input_image, standard_deviation)
    % Gaussian kernel is typically 6 times standard deviation
    kernel_size = ceil(6 * standard_deviation);

    if mod(kernel_size, 2) == 0
        kernel_size = kernel_size + 1; % Ensure kernel size is odd
    end

    % Create 1D Gaussian kernel
    index = -(kernel_size - 1) / 2 : (kernel_size - 1) / 2;
    gauss_kernel = exp(-(index .^ 2) / (2 * standard_deviation ^ 2));
    gauss_kernel = gauss_kernel / sum(gauss_kernel); % Normalize the kernel
    
    % Convolution using a 2D gaussian is replaced with a horizontal
    % pass and a vertical pass below

    % First, apply horizontal convolution
    smoothed_horizontally = conv2(input_image, gauss_kernel, 'same');
    % Then, apply vertical convolution
    smoothed_image = conv2(smoothed_horizontally, gauss_kernel', 'same');

    % Visualizing outputs
    %subplot(1, 2, 1), imshow(input_image), title('Original Image');
    %subplot(1, 2, 2), imshow(smoothed_image), title('Smoothed Image');
end
