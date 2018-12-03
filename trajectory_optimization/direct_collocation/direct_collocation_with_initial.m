% Direct collocation with initial variable values passed as arguments

function [z_sol] = direct_collocation_with_initial(...
    x0, xf, nu, N, Dt, dynamics, u_lower, u_upper, x_init, u_init)

    % Obtaining parameters ------------------------------------------------
    nx = length(x0);
    assert(length(xf) == nx);
    
    % Initializing --------------------------------------------------------
    z = zeros(nx*N + nu*N, 1);
    
    % Linear constraint matrices ------------------------------------------
    Aeq = zeros(2*nx, length(z));
    beq = zeros(2*nx, 1);
    Aeq(1:nx, 1:nx) = eye(nx);
    Aeq(nx+1:2*nx, end-nx-nu+1:end-nu) = eye(nx);
    beq(1:nx) = x0;
    beq(nx+1:end) = xf;
    
    % Solving -------------------------------------------------------------

    z0 = zeros(size(z));
    
    for i=1:N
        x_i_inds = (1:nx) + (nx + nu) * (i - 1);
        u_i_inds = (1:nu) + nx*i + nu*(i - 1);
        z0(x_i_inds) = x_init(:, i);
        z0(u_i_inds) = u_init(:, i);
    end
    

    lb = -inf(numel(z), 1);
    ub = inf(numel(z), 1);
    
    for i=1:N
        
        lb((nx + nu)*(i - 1) + nx + 1: (nx + nu)*(i - 1) + nx + nu) = u_lower;
        ub((nx + nu)*(i - 1) + nx + 1: (nx + nu)*(i - 1) + nx + nu) = u_upper;
        
    end
 
    % Options -------------------------------------------------------------
    options = optimoptions('fmincon', ...
        'SpecifyObjectiveGradient', true, ...
        'SpecifyConstraintGradient', true, ...
        'Display', 'iter');
    
    problem.objective = @(z) compute_objective(z, nx, nu, N, Dt);
    problem.x0 = z0;
    problem.options = options;
    problem.nonlcon = @(z) compute_nonlcon(z, nx, nu, N, Dt, dynamics);
    problem.solver = 'fmincon';
    problem.Aeq = Aeq;
    problem.beq = beq;
    problem.lb = lb;
    problem.ub = ub;
    
    disp('Solving');

    z_sol = fmincon(problem);

    