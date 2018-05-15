function theta_vec = log_normal(gamma_vec, w_mat, n)

v1 = gamma_vec' * w_mat'; % is  a row
m1 = reshape(v1, n - 1, n); % when mat, it is a row or col does not matter
v_min = min(m1)'; % is a col
v1 = exp(-v1' + reshape((v_min * ones(1, n-1))', n*(n-1), 1));
v_norm = sum(reshape(v1, n - 1, n)); % is a row
theta_vec = - v_min + log(v_norm');%??
%theta_vec = - v_min * (N-1) + log(v_norm);%??


