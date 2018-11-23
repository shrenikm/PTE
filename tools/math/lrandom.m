% Function to return a random number between two limits

function [res] = lrandom(lb, ub, dim)

    if nargin == 2
        res = lb + (ub - lb)*rand;
    elseif nargin == 3
        res = lb + (ub - lb)*rand(dim);
    else
        error('Incorrect number of input arguments.');
    end

end

