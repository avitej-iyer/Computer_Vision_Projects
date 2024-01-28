% Step 5 of the algorithm

function corner_value = harris_corner_detection(Gx, Gy, N, k)

    % Computing the products of derivatives 
    gx_gx = Gx .* Gx;
    gy_gy = Gy .* Gy;
    gxy = Gx .* Gy;

    % Computing sums of the products over local NxN neighbourhood
    box = ones(N,N);

    sum_x2 = conv2(gx_gx, box, 'same');
    sum_y2 = conv2(gy_gy, box, 'same');
    sum_xy = conv2(gxy, box, 'same');
    
    % Compute Harris corner value at each pixel

    % det(H) = sum_x2*sum_y2 - (sum_xy * sum_xy) and trace(H) = sum_x2 + sum_y2

    corner_value = (sum_x2 .* sum_y2 - (sum_xy .* sum_xy)) - k .* (sum_x2 + sum_y2) .^2;

end