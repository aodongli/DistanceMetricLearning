%EM_train.m
n_iter=1;      total_likelihood=[];     fval_array=[];
% randomly initialize gamma        
gamma_vec=rand(n_top_eigenK,1); %eigen_value(n_top_eigenK,1); %ones(n_top_eigenK,1); %   
while(n_iter<EM_n_max_iter)
    % posterior           
    alpha_vec=cal_alpha(gamma_vec,w_mat,n_train_img-1, n_train_img,delta_vec,leave_one_out_index_t);
    % fmincon -> gamma vec  

    options=optimset('Gradobj','on','maxiter',maxiter_value,'Display','iter');
    %options=optimset('Gradobj','off','MaxIter',5000,'Display', 'iter','MaxFunEvals',5000,'TolFun',1e-10); 

    [gamma_vec,fval,exitflag,output,lambda,grad,hessian] =  fmincon('cal_obj_gamma',gamma_vec,[],[],[],[],zeros(n_top_eigenK,1),[],[],options);
    fval_array=[fval_array, fval];
    %cal likelihood
    current_total_likelihood=cal_likelihood(gamma_vec,delta_vec,w_mat,n_train_img);
    %terminate condition
    if n_iter>1 && abs(total_likelihood(end)- current_total_likelihood) < EM_min_exit_dist
        %||(n_iter>1 && abs(fval_array(end)-fval_array(end-1))<1e-2)
        break; 
    end
    total_likelihood=[total_likelihood,current_total_likelihood];    
    n_iter=n_iter+1;
end 


