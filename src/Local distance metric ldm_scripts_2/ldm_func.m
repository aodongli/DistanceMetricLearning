function [gamma_vec, ldm_train_test_dist] = ldm_func(U_train_mat, U_test_mat, train_label_vec, test_label_vec, eigen_percent, maxiter_value)
% %%%%%%%%%%%%%%%%%%% Input %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% U_train_mat - #dimension * #training sample
% U_test_mat  - #dimension * #testing sample
% train_label_vec  - #training sample * 1
% test_label_vec   - #testing sample * 1
% eigen_percent  -  the percent of eigen information used for training 
% maxiter_value  -  the maximum number of iteration of fmincon() function

% %%%%%%%%%%%%%%%%%% Output %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% gamma_vec - n_top_eigenK * 1; the learnt gamma vector; where
% n_top_eigenK is dependent on eigen_percent
% ldm_train_test_dist - #training sample * #testing sample; 
% the pairwise distance matrix between training samples and testing samples 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global w_mat; 
global alpha_vec; 
global n_train_img;
[eigen_mat,n_top_eigenK]=cal_eigen_mat([U_train_mat, U_test_mat],eigen_percent);
EM_n_max_iter = 100;
EM_min_exit_dist = 1e-3;
n_train_img = size(U_train_mat, 2);
n_test_img = size(U_test_mat, 2);
leave_one_out_index_t = leave_one_out_index(n_train_img);
delta_vec= cal_delta(train_label_vec , train_label_vec, leave_one_out_index_t);
w_mat=cal_w_mat(U_train_mat,U_train_mat,leave_one_out_index_t,eigen_mat);    
w_mat_train_test= cal_w_mat(U_train_mat, U_test_mat,[],eigen_mat);
EM_train
ldm_train_test_dist = my_mat(gamma_vec'*w_mat_train_test',n_train_img,n_test_img);   
