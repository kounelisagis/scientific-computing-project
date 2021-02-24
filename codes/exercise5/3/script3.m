N = 2^7 - 1;
tol = 1.e-6;
omega = 0;
h = 1/(N+1);
p = -1;
global w; w = 4-(omega*h)^2;

A = create_coefficient_matrix(N);

try chol(A);
    disp('Matrix is symmetric positive definite.')
catch ME
    disp('Matrix is not symmetric positive definite')
end

u = ones(N^2,1);
g = A*u;



profile on
[x,flag,relres,iter,resvec] = pcg(@myMV,g,tol,N^2);
profile off
profsave(profile('info'), 'without')
semilogy(resvec/norm(g),'-o'); hold on;
accuracy = norm(x-u);  % the less - the better
err_norm = relres*norm(g);
fprintf('Matrix%d: flag = %d, accuracy = %f, err_norm = %f\n', 1, flag, accuracy, err_norm);


L = ichol(A);
profile on
[x,flag,relres,iter,resvec] = pcg(@myMV,g,tol,N^2,L,L');
profile off
profsave(profile('info'), 'chol')
semilogy(resvec/norm(g),'-x');
accuracy = norm(x-u);  % the less - the better
err_norm = relres*norm(g);
fprintf('Matrix%d: flag = %d, accuracy = %f, err_norm = %f\n', 2, flag, accuracy, err_norm);


[L,U] = ilu(A);
profile on
[x,flag,relres,iter,resvec] = pcg(@myMV,g,tol,N^2,L,U);
profile off
profsave(profile('info'), 'lu')
semilogy(resvec/norm(g),'-^');
accuracy = norm(x-u);  % the less - the better
err_norm = relres*norm(g);
fprintf('Matrix%d: flag = %d, accuracy = %f, err_norm = %f\n', 3, flag, accuracy, err_norm);


title("Number of Iterations - norm-2 of Relative Residual")
xlabel('Iteration number')
ylabel('Relative residual')
legend('PCG - no preconditioning', 'PCG - ichol preconditioning', 'PCG - ilu preconditioning');
hold off

