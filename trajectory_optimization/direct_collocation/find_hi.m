% Function to extract hi from z
function [hi] = find_hi(i, z, n, p)

    hi = z((n + p)*(i - 1) + 1: (n + p)*(i - 1) + n + p);

end