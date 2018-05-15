rng('default');
% number of samples
N = 20;
% number of dimensions
d = 2;
% classes
C1 = 5+1*randn(N/2,d);
C1 = [C1; -5+1*randn(N/2,d)];
C2 = 10+2*randn(N/2,d);
C2 = [C2; -10+2*randn(N/2,d)];
% standadization
mu = mean([C1;C2]);
sigma = std([C1;C2]);
mu = repmat(mu,N,1);
sigma = repmat(sigma,N,1);
C1 = (C1-mu)./sigma;
C2 = (C2-mu)./sigma;
% size of S set and D set
N2 = 100;
S_set = randi(N,N2,2); % 1st half in C1, 2nd half in C2
D_set = randi(N,N2,2); % D_set(:,1) for C1, D(:,2) for C2

distS = zeros(N2,d);
distD = zeros(N2,d);
for i = 1:round(N2/2)
    distS(i,:) = C1(S_set(i,1),:) - C1(S_set(i,2),:);
end
for i = round(N2/2):N2
    distS(i,:) = C2(S_set(i,1),:) - C2(S_set(i,2),:);
end
MS = zeros(d,d);
% xAx' = trace(xx'A) 
for i = 1:N2
    MS = MS + distS(i,:)'*distS(i,:);
end

for i = 1:N2
    distD(i,:) = C1(D_set(i,1),:) - C2(D_set(i,1),:);
end


% original algorithm
datat = [C1;C2];
label = [zeros(N,1);ones(N,1)];
A = lmnn(datat, label)
S = zeros(2*N,2*N);
D = zeros(2*N,2*N);
for i = 1:round(N2/2)
    S(S_set(i,1),S_set(i,2)) = 1;
end
for i = round(N2/2):N2
    S(S_set(i,1)+N,S_set(i,2)+N) = 1;
end
for i = 1:N2
    D(D_set(i,1),D_set(i,2)+N) = 1;
end
C = 1;
%{
tic;
A = Newton(datat, S, D, C) % diagonal matrix
toc;

A = eye(d);
t = 1;
w = unroll(MS);
tic;
A = iter_projection_new2(datat, S, D, A, w, t, 10000) % full matrix
toc;
%}

% CVX
%{
tic;
cvx_begin sdp
    variable A(d,d) %diagonal
    minimize( norm(MS*A, 'fro') );
    fD = 0;
    for i = 1:N2
        fD = fD + sqrt(distD(i,:)*A*distD(i,:)');
    end
    fD >= 1;
    A >= 0;
cvx_end
toc;
%}

t_C1 = zeros(size(C1));
t_C2 = zeros(size(C2));
L = sqrtm(A);
for i = 1:N
    t_C1(i,:) = (L*C1(i,:)')';
end
for i = 1:N
    t_C2(i,:) = (L*C2(i,:)')';
end


figure(1);
%subplot(1,2,1);
plot(C1(:,1), C1(:,2), 'r*');
hold on;
plot(C2(:,1), C2(:,2), 'bo');
xlabel('x_1'); ylabel('x_2');
legend('Class1','Class2');

figure(2);
%subplot(1,2,2);
plot(t_C1(:,1), t_C1(:,2), 'r*');
hold on;
plot(t_C2(:,1), t_C2(:,2), 'bo');
%axis([-20,20,-20,20]);
xlabel('x_1'); ylabel('x_2');
legend('Class1','Class2');