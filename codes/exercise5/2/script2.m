n=500; A = randn(n); xsol = rand(n,1); b = A*xsol;
tol = 1e-6; maxit = 4*n;
markers = {'-', '-', '-'};

T = zeros(1,4);

for k=1:3
    profile on
    tic
    if k==1
        [x,flag,relres,iter,resvec] = pcg(A'*A,A'*b,tol,maxit);
    elseif k==2
        [x,flag,relres,iter,resvec] = gmres(A,b,100,tol,maxit);
        resvec = resvec(1:1000);
    else
        [x,flag,relres,iter,resvec] = gmres(A,b,n,tol,maxit);
    end
    T(k)= toc;
    profile off
    profsave(profile('info'), num2str(k))

    semilogy(resvec/norm(b),markers{k}); if k==1, hold on; end

    accuracy = norm(x-xsol);  % the less - the better
    err_norm = relres*norm(b);
    cond = condest(A);
    fprintf('Method%d: flag = %d, accuracy = %f, err_norm = %f, cond = %f\n', k, flag, accuracy, err_norm, cond);
end

title("Number of Iterations - norm-2 of Relative Residual")
xlabel('Iteration number')
ylabel('Relative residual')
legend('pcg', 'gmres(m)', 'gmres(n)');
hold off

tic
x = A\b;
T(4) = toc;
