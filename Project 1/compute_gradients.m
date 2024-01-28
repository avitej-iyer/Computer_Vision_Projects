% This is step 4 for the algorithm described in the project

function [Gx, Gy] = compute_gradients(input_image)
    % Define finite difference kernels for partial derivatives
    kernel_x = [1, 0, -1]; % For Gx
    kernel_y = [1; 0; -1]; % For Gy

    % Convolve the smoothed image with the kernels to compute gradients
    Gx = conv2(input_image, kernel_x, 'same'); % Gradient in x-direction
    Gy = conv2(input_image, kernel_y, 'same'); % Gradient in y-direction

    subplot(1, 3, 1), imshow(input_image), title('Original Image');
    subplot(1, 3, 2), imshow(Gx), title('Gx');
    subplot(1, 3, 3), imshow(Gy), title('Gy');
end