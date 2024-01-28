% This functions overlays red boxes onto the "best" corners 

function [] = visualize_corners(image, corners)

    imshow(image), hold on;
    box_half_size = 3; % Half size of the box, for a 7x7 box, half size is 3
    
    for i = 1:size(corners, 1)
        % Calculate the top-left corner of the box
        top_left_x = corners(i, 2) - box_half_size;
        top_left_y = corners(i, 1) - box_half_size;
    
        % Draw a 7x7 red box
        rectangle('Position', [top_left_x, top_left_y, 7, 7], 'EdgeColor', 'r', 'LineWidth', 1.5);
    end
    
    hold off;
    title('Sparse Corner Features with Red Boxes');
end
