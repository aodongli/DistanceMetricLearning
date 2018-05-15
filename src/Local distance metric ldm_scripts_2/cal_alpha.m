function alpha_vec=cal_alpha(gamma_vec,w_mat,n_train_img, n_test_img,delta_vec,leave_one_out_index_t)

% alpha_vec  (n_train_img)n_test_img * 1

% for leave-one-out in training, n_train_img=n_labeled-1;
% n_test_img=n_labeled
% for testing case, it is straitforward.
% delta_vec and w_mat are both leave-one-out; alpha need not; but notice
% the n_train_img should be n_train_img-1; if leave_one_out_index_t is not
% empty
v1 = w_mat * gamma_vec;
m1 = reshape(v1, n_train_img, n_test_img);
v_min = min(m1)';
v1 = exp(-v1 + reshape((v_min * ones(1, n_train_img))', n_test_img*n_train_img, 1));

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% v1 = v1.*delta_vec +1e-200;    
% v_norm = sum(reshape(v1, n_train_img, n_test_img)); 
% v_norm = reshape((v_norm' * ones(1, n_train_img))', n_test_img*n_train_img, 1);
% alpha_vec = v1./v_norm; 
% % outlier, far away from all training data point, zero -> uniform


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% new version
v1 = v1.*delta_vec;
v_norm = sum(reshape(v1, n_train_img, n_test_img)); 
v_norm(v_norm ==0)= 1e+200; % replace them with 1e +200 to eliminate 
v_norm = reshape((v_norm' * ones(1, n_train_img))', n_test_img*n_train_img, 1);
alpha_vec = v1./v_norm; 
% outlier, far away from all training data point, zero -> uniform

