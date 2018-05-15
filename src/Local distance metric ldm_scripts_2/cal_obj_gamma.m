function [f,g]=cal_obj_gamma(gamma_vec)

global w_mat; 
global alpha_vec; 
global n_train_img;

% obj
f = alpha_vec' * w_mat * gamma_vec;
% t = 0.1*ones(length(gamma_vec),1);  % t is a col
% f = alpha_vec' * w_mat * gamma_vec + t'*gamma_vec; % laplacian proir, regulizer
f = f + sum(log_normal(gamma_vec, w_mat, n_train_img));
if f < 0
    k =0;
end

% 1st order
if nargout > 1  
    theta_vec = max_normal(gamma_vec, w_mat, n_train_img);
    g = - w_mat' * (-alpha_vec + theta_vec);
end
