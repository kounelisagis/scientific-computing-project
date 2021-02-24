N = 5;
omega = 1;
h = 1/(N+1);
p = -1;
global w; w = 4-(omega*h)^2;

% 1
A = create_coefficient_matrix(N);
% spy(A)


% 2
z = randn(size(A,1),1);
y_ideal = A*z;
y = myMV(z);
norm(y-y_ideal)
