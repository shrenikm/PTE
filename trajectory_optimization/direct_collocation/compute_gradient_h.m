% Computing the gradient of h
function [H_grad] = compute_gradient_h(z, n, p, N, Dt, dynamics)

    H_grad = zeros((N-1)*n, numel(z));
    
    delta = 1e-8;
    
    for i=1:N-1
        
        h_curr = find_hi(i, z, n, p);
        h_next = find_hi(i+1, z, n, p);
        h_grad = zeros(n, 2*(n+p));
        for j=1:n
            
            tmp_curr = h_curr;
            tmp_curr(j) = tmp_curr(j) + delta;
            tmp_curr = insert_hi(i, tmp_curr, z, n, p);
            tmp_curr = compute_h(tmp_curr, n, p, N, Dt, dynamics);
            tmp_next = h_next;
            tmp_next(j) = tmp_next(j) + delta;
            tmp_next = insert_hi(i+1, tmp_next, z, n, p);
            tmp_next = compute_h(tmp_next, n, p, N, Dt, dynamics);
            disp(size(find_hi(i, tmp_curr, n, p)));
            h_grad(:, j) = (find_hi(i, tmp_curr, n, p) - ...
                h_curr)/delta;
            h_grad(:, n+p+j) = (find_hi(i+1, tmp_next, n, p) - ...
                h_next)/delta;
        end
        
        disp('done x');
        
        for j=1:p
            
            tmp_curr = h_curr;
            tmp_curr(n+j) = tmp_curr(n+j) + delta;
            tmp_curr = insert_hi(i, tmp_curr, z, n, p);
            tmp_curr = compute_h(tmp_curr, n, p, N, Dt, dynamics);
            tmp_next = h_next;
            tmp_next(n+j) = tmp_next(n+j) + delta;
            tmp_next = insert_hi(i+1, tmp_next, z, n, p);
            tmp_next = compute_h(tmp_next, n, p, N, Dt, dynamics);
            h_grad(:, n+j) = (find_hi(i, tmp_curr, n, p) - ...
                h_curr)/delta;
            h_grad(:, 2*n+p+j) = (find_hi(i+1, tmp_next, n, p) - ...
                h_next)/delta;
                        
        end
        
        disp('done u');
        
        disp(h_grad);
        
        H_grad(n*(i-1)+1:n*(i-1)+n, (n+p)*(i-1)+1:(n+p)*(i-1)+2*(n+p)) = h_grad;
        
    end

end