function t=leave_one_out_index(N)
% N is n_labeled_img
t=[];
for i=1:N
    t=[t,(i-1)*N+i];
end