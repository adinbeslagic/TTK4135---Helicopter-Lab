function [c, ceq] = ineqcon(z)
    global alpha beta lambda_t mx N
    c = zeros(N, 1);
    ceq = [];
    for k = 1:N
        c(k) = alpha*exp(-beta*(z(1+(k-1)*mx)-lambda_t)^2) - z(5+(k-1)*mx);
    end
end