% Function to extract ui from z
function [ui] = find_ui(i, z, nx, nu)

    ui = z((nx + nu)*(i - 1) + nx + 1: (nx + nu)*(i - 1) + nx + nu);

end