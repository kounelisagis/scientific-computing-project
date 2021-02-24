n=500;
matrices = {spdiags([1:n]',[0],n,n), spdiags([linspace(1,2,n/2)';linspace(1000,1001,n/2)'],[0],n,n)'};
tol = 1e-6; maxit = 4*n;
markers = {'-o', '-x'};

for k=1:length(matrices)
    A = matrices{k};
    xsol = ones(n,1);
    b = A*xsol;

    profile on
    [x,flag,relres,iter,resvec] = pcg(A,b,tol,maxit);
    profile off
    profsave(profile('info'), num2str(k))

    semilogy(resvec/norm(b),markers{k}); if k==1, hold on; end

    accuracy = norm(x-xsol);  % the less - the better
    err_norm = relres*norm(b);
    cond = condest(A);
    fprintf('Matrix%d: flag = %d, accuracy = %f, err_norm = %f, cond = %f\n', k, flag, accuracy, err_norm, cond);
end

title("Number of Iterations - norm-2 of Relative Residual")
xlabel('Iteration number')
ylabel('Relative residual')
legend('matrix1', 'matrix2');
hold off
