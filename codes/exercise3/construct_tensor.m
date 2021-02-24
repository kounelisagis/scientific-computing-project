function G = construct_tensor(A, k)
    n = length(A);
    M = zeros(n,n,k);
    M(:,:,1) = A;
    for i=2:k
        M(:,:,i) = M(:,:,i-1)*A;
    end
    G = tensor(M);
end
