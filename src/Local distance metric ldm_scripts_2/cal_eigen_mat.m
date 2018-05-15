function [eigen_mat,n_top_eigenK]=cal_eigen_mat(X,eigen_percent)
% each col is an image
% pick top n_top_eigenK
if issparse(X)==1 % svds is inaccurate
    [eigen_mat,S,V]=svd(full(X*X'));
    s_diag=diag(S);
    eigen_mat=sparse(eigen_mat);    
    %n_top_eigenK=11; only for paresed
    total=sum(s_diag);
    i=1;
    aa=length(s_diag);
    while i<=aa
        tmp=sum(s_diag(1:i));
        if tmp/total>=eigen_percent
            n_top_eigenK=i; 
            break; 
        end  
        i=i+1;
    end 

else 
    % SVD of covariance matrix XX'
    [eigen_mat,S,V]=svd(X*X'); 
    s_diag=diag(S);
    total=sum(s_diag);
    i=1;    
    aa=length(s_diag);
    while i<=aa
        tmp=sum(s_diag(1:i));
        if tmp/total>=eigen_percent
            n_top_eigenK=i;
            break; 
        end  
        i=i+1;
    end 
end 
eigen_mat=eigen_mat(:,1:n_top_eigenK);


