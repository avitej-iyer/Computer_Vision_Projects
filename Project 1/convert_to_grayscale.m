% This is step 1 for the algorithm described in the project

function double_image = convert_to_grayscale(image_filename)
    % Read the image from the provided filename
    original_image = imread(image_filename);
    
    % Convert to grayscale if it is a color image
    if size(original_image, 3) == 3
        grayscale_image = rgb2gray(originalImage);
    else
        grayscale_image = original_image; % The image is already in grayscale
    end

    % Convert to double precision floating-point
    double_image = im2double(grayscale_image);

    % Display the original and the processed images - for testing purposes
    %subplot(1, 2, 1), imshow(originalImage), title('Original Image');
    %subplot(1, 2, 2), imshow(doubleImage), title('Grayscale Double Precision Image');

end