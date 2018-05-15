% mat.m
function B=my_mat(A,m,n)
% A is a n1*n2 matrix =>  B(m,n)
[n1,n2]=size(A);
if n1*n2~=m*n display('error at mat : do not have m*n elements'); end
B=reshape(A,m,n);
