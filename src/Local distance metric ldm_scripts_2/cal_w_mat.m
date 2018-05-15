function w_mat=cal_w_mat(U_mat1,U_mat2,leave_one_out_index_t,eigen_mat)

% train: U_mat1= train_mat=U_mat2; leave_one_out_index_t is nonempty
% test: U_mat1= train_mat; U_mat2=test_mat ; leave_one_out_index_t is empty
% U_mat2 is the one being left one


[n_dim,n1]=size(U_mat1);
[n_dim,n2]=size(U_mat2);

% left
left_sub=repmat(U_mat1', n2, 1);
left_sub(leave_one_out_index_t,:)=[];

% right
%right_sub=(mat((repmat(U_mat2',1,n1))',n_dim,n1*n2))';
right_sub=(my_mat((repmat(U_mat2',1,n1))',n_dim,n1*n2))';
right_sub(leave_one_out_index_t,:)=[]; 

% subtractoin
diff_mat=left_sub-right_sub; % diff_mat N*(N-1)

w_mat=diff_mat*eigen_mat;
w_mat=w_mat.^2; 



