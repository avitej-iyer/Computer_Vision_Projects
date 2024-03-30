% Step 1

function returning_2d_points = projectAndVisualize(pts3D, Parameters, adjust, image, printer)
%     Extract the intrinsic matrix (K) and the rotation matrix (R) from Parameters
%     K = Parameters.Kmat;
%     R = Parameters.Rmat;
%     
%     The position vector needs to be converted to a translation vector
%     t = -R * Parameters.position';
% 
%     Construct the extrinsic parameter matrix
%     extrinsicMat = [R, t];
%     
%     Construct the full projection matrix
%     P = K * extrinsicMat;
%     
%     Convert 3D points to homogeneous coordinates
%     pts3D_homogeneous = [pts3D; ones(1, size(pts3D, 2))];
%     
%     Project 3D points to 2D using the projection matrix
%     pts2D_homogeneous = P * pts3D_homogeneous;
%     
%     Convert back to Cartesian coordinates
%     returning_2d_points = pts2D_homogeneous(1:2, :) ./ pts2D_homogeneous(3, :);
%     
%     Junk code for debugging
%     {
%     img = imread(imageFile);
%     imshow(img);
%     hold on;
%     
%     plot(pts2D(1, :), pts2D(2, :), 'ro', 'MarkerSize', 5, 'LineWidth', 1.5);
%     title('Projected 2D Points on Image');
%     hold off;
%     }
    cam_pixel_locations = [];
    r_mat = Parameters.Rmat;
    if isa(adjust, "string")
        k_mat = Parameters.Kmat;
    else
        k_mat = adjust;
    end
    p_mat = Parameters.Pmat;
    pos = Parameters.position;
    pos_vec = [pos(1); pos(2); pos(3)];

    for col = 1:size(pts3D,2)
        mocap_vector = [pts3D(1, col); pts3D(2, col); pts3D(3, col); 1];

        t = (-1 * r_mat) * pos.';
        world_to_cam = [r_mat, t; 0,0,0,1];

        mocap_cam_cords = world_to_cam * mocap_vector;

        f = Parameters.foclen;
        f_mat = [f, 0, 0, 0; 0, f, 0, 0; 0, 0, 1, 0];
        homogenous_cords = f_mat * mocap_cam_cords;

        pixel_loc = k_mat * mocap_cam_cords(1:3);
        pixel_loc = pixel_loc / pixel_loc(3);
        cam_pixel_locations = [cam_pixel_locations pixel_loc];
    end
   returning_2d_points = cam_pixel_locations(1:2, :);

   if eq(printer, 1)
    if isa(image, "string")
        image = imread(image);
    end
    imshow(image);
    hold on;
    
    plot(returning_2d_points(1, :), returning_2d_points(2, :), 'ro', 'MarkerSize', 5, 'LineWidth', 1.5);
    title('Projected 2D Points on Image');
    hold off;
   end

end