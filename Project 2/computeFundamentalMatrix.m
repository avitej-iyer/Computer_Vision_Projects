function F = computeFundamentalMatrix(Parameters_V1, Parameters_V2)
    % Extract Camera Parameters
    R1 = Parameters_V1.Rmat;
    C1 = -R1' * Parameters_V1.position';
    K1 = Parameters_V1.Kmat;
    
    R2 = Parameters_V2.Rmat;
    C2 = -R2' * Parameters_V2.position';
    K2 = Parameters_V2.Kmat;

    % Relative Orientation and Position
    R_rel = R2 * R1';
    t_rel = C2 - C1;  % Relative position of Camera 2's center in world coordinates

    % Skew-symmetric matrix for t_rel
    t_rel_x = [0, -t_rel(3), t_rel(2); t_rel(3), 0, -t_rel(1); -t_rel(2), t_rel(1), 0];

    % Essential Matrix
    E = t_rel_x * R_rel;

    % Fundamental Matrix
    F = inv(K2)' * E * inv(K1);
end
