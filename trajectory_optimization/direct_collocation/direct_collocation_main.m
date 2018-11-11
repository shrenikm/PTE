% Main function to run that performs direct collocation

function [] = direct_collocation(x0, xf, p, N, Dt, dynamics)

    % Obtaining parameters ------------------------------------------------
    n = length(x0);
    assert(length(xf) == n);
    
    % Initializing --------------------------------------------------------
    z = zeros(n*N + p*(N - 1));
    
    % Obtaining indices ---------------------------------------------------
    

end