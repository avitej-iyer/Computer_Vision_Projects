function F = computeFundamentalMatrix(params1, params2, K1_new, K2_new)

    if isstring(K1_new)
        K1 = params1.Kmat;  % Intrinsic matrix for Camera 1
        K2 = params2.Kmat;  % Intrinsic matrix for Camera 2
    else
        K1 = K1_new;    % Changed intrinsic matrices for extra credit  
        K2 = K2_new;    
    end
  

    R1 = params1.Rmat;  % Rotation matrix for Camera 1
    R2 = params2.Rmat;  % Rotation matrix for Camera 2
        
    Position_1 = params1.position;
    Position_2 = params2.position;
    
    
    translation_vec = R1 * transpose((Position_2 - Position_1));
    
    Smat = [0 -translation_vec(3) translation_vec(2);
                   translation_vec(3) 0 -translation_vec(1);
                   -translation_vec(2) translation_vec(1) 0];
    
    % Compute relative rotation and Essential matrix
    relative_Rmat = R2 * transpose(R1); 
    E = relative_Rmat * Smat;
    
    % Converting E to F
    F = transpose(inv(K2)) * E * inv(K1);


end

