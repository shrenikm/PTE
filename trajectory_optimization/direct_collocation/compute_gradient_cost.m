function dg = compute_gradient_cost(z, n, p, N, Dt)
dG = zeros(N*(n + p),1);

for i=1:(N-1)

  u_i_inds = (1:p) + n * i + p * (i - 1);
  u_ip1_inds = (1:p) + n * (i+1) + p * i;

  u_i = z(u_i_inds);
  u_ip1 = z(u_ip1_inds);

  %Updating cost gradient
  dG(u_i_inds) = dG(u_i_inds) + u_i*Dt;
  dG(u_ip1_inds) = dG(u_ip1_inds) + u_i*Dt;


end
end