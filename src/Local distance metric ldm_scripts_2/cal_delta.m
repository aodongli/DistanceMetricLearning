function delta_vec=cal_delta(label_vec1,label_vec2,leave_one_out_index_t)

% cal the difference between two label_vec, label_vec2 is the one left out

% train: label_vec1=train_label_vec ; label_vec2=train_label_vec; and
% leave_one_out_index_t nonempty
% test:  label_vec1=train_label_vec ; label_vec2=test_label_vec; and
% leave_one_out_index_t is empty

n1=length(label_vec1);
n2=length(label_vec2);

left_sub=repmat(label_vec1,n2,1);
left_sub(leave_one_out_index_t,:)=[];

right_sub=vec(repmat(label_vec2',n1,1));
right_sub(leave_one_out_index_t,:)=[];

% delta_vec (n_labeled_img-1)n_labeled_img * 1
delta_vec=double((left_sub==right_sub));

