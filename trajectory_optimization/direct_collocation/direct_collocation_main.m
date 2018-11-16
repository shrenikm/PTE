% Main function to run that performs direct collocation

function [] = direct_collocation_main(x0, xf, p, N, Dt, dynamics)

    % Obtaining parameters ------------------------------------------------
    n = length(x0);
    assert(length(xf) == n);
    
    % Initializing --------------------------------------------------------
    z = zeros(n*N + p*N, 1);
    
    % Linear constraint matrices ------------------------------------------
    Aeq = zeros(2*n, length(z));
    beq = zeros(2*n, 1);
    Aeq(1:n, 1:n) = eye(n);
    Aeq(n+1:2*n, N-n-p+1: N-p) = eye(n);
    beq(1:n) = x0;
    beq(n+1:end) = xf;
    
    % Solving -------------------------------------------------------------
%     fun = @(z) compute_cost(z, n, p, N, Dt);
%     nonlcon = @(z) compute_nonlcon(z, n, p, N, Dt, dynamics);

    z0 = zeros(size(z));
    
    
    % z init value (interpolated)
    x_0_inds = 1:n;
    x_f_inds = x_0_inds + (N - 1) * (n + p);

    difference = (xf - x0)/(N-1);
    for i=1:N
        x_i_inds = (1:n) + (n + p) * (i - 1);
        x = x0 + difference*(i-1); 
        z0(x_i_inds) = x;
    end    

    lb = -inf(numel(z), 1);
    ub = inf(numel(z), 1);
 
    % Options -------------------------------------------------------------
    options = optimoptions('fmincon', ...
        'SpecifyObjectiveGradient', true, ...
        'SpecifyConstraintGradient', true, ...
        'Display', 'iter');
    
    problem.objective = @(z) compute_cost(z, n, p, N, Dt);
    problem.x0 = z0;
    problem.options = options;
    problem.nonlcon = @(z) compute_nonlcon(z, n, p, N, Dt, dynamics);
    problem.solver = 'fmincon';
    problem.Aeq = Aeq;
    problem.beq = beq;
    problem.lb = lb;
    problem.ub = ub;
    
    disp('Solving');

    z_sol = fmincon(problem);
    
      

end