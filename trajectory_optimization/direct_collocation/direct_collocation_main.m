% Main function to run that performs direct collocation, with or without
% initial estimates of x and u

function [z_sol] = direct_collocation_main(...
    x0, xf, nu, N, Dt, dynamics, u_lower, u_upper, ind, varargin)
    
    % Indicates if initial estimates of x and u provided. Value is set to 1
    % if they are provided.
    init_flag = 0;

    if size(varargin,2) == 2
        x_init = varargin{1};
        u_init = varargin{2};
        init_flag = 1;        
    end

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
    
    % Reducing Aeq and beq to corresponding indices
    new_ind = [1:nx, nx + ind];
    Aeq = Aeq(new_ind, :);
    beq = beq(new_ind, :);
    
    
    % Solving -------------------------------------------------------------

    z0 = zeros(size(z));
       
    if ~init_flag %% No initial condition for x and u provided
        difference = (xf - x0)/(N-1);
        for i=1:N
            x_i_inds = (1:nx) + (nx + nu) * (i - 1);
            x = x0 + difference*(i-1); 
            z0(x_i_inds) = x;
        end
    else    %% Initial estimates for x and u provided
        for i=1:N
            x_i_inds = (1:nx) + (nx + nu) * (i - 1);
            u_i_inds = (1:nu) + nx*i + nu*(i - 1);
            z0(x_i_inds) = x_init(:, i);
            z0(u_i_inds) = u_init(:, i);            
        end
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
    
end