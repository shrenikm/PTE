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
    nonlcon = @(z) compute_h(z, n, p, N, Dt, dynamics);
    z0 = zeros(size(z));
    
    
    % Based on code from hw-5
    x_0_inds = 1:n;
    x_f_inds = x_0_inds + (N - 1) * (n + p);

    difference = (xf - x0)/(N-1);
    for i=1:N
        x_i_inds = (1:n) + (n + p) * (i - 1);
        x = x0 + difference*(i-1); 
        z0(x_i_inds) = x;
    end    

    
    
    % Options -------------------------------------------------------------
    options = optimoptions('fmincon', 'Display', 'iter');
    
    disp('Solving');
    z_sol = fmincon(fun, z0, [], [], A, b, [], [], nonlcon, options);
    
      

end