% Main function to run that performs direct collocation

function [] = direct_collocation_main(x0, xf, p, N, Dt, dynamics)

    % Obtaining parameters ------------------------------------------------
    n = length(x0);
    assert(length(xf) == n);
    
    % Initializing --------------------------------------------------------
    z = zeros(n*N + p*N, 1);
    
    % Linear constraint matrices ------------------------------------------
    A = zeros(2*n, length(z));
    b = zeros(2*n, 1);
    A(1, 1:n) = ones(n, 1);
    A(2, N-n-p+1: N-n-p+n) = ones(n, 1);
    b(1:n) = x0;
    b(n+1:end) = xf;
    
    % Solving -------------------------------------------------------------
    fun = @(z) compute_cost(z, n, p, N, Dt);
    nonlcon = @(z) compute_nonlcon(z, n, p, N, Dt, dynamics);
    z0 = zeros(size(z));
    
    % Options -------------------------------------------------------------
    options = optimoptions('fmincon', ...
        'SpecifyObjectiveGradient', false, ...
        'SpecifyConstraintGradient', true, ...
        'Display', 'iter');
    
    disp('Solving');
    z_sol = fmincon(fun, z0, [], [], A, b, [], [], nonlcon, options);
    
      

end