function [cropped_image, new_intrinsic_matrix] = cropAndChangeIntrinsicMatrix(source_image, old_intrinsic_matrix, crop_x, crop_y)

x_offset = min(crop_x);
y_offset = min(crop_y);

cropped_image = imcrop(imread(source_image), [x_offset y_offset abs(diff(crop_x)) abs(diff(crop_y))]);

new_intrinsic_matrix = old_intrinsic_matrix;

new_intrinsic_matrix(1,3) = old_intrinsic_matrix(1,3) - x_offset;
new_intrinsic_matrix(2,3) = old_intrinsic_matrix(2,3) - y_offset;

end

