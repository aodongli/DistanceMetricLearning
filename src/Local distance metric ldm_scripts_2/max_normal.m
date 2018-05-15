function theta_vec = max_normal(gamma_vec, w_mat, n)

v1 = w_mat * gamma_vec;
m1 = reshape(v1, n - 1, n);
v_min = min(m1)';
v1 = exp(-v1 + reshape((v_min * ones(1, n-1))', n*(n-1), 1));
v_norm = sum(reshape(v1, n - 1, n));
v_norm = reshape((v_norm' * ones(1, n-1))', n*(n-1), 1);
theta_vec = v1 ./ v_norm;







