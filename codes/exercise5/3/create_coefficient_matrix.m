function A = create_coefficient_matrix(N)

    global w
    A = zeros(N^2,N^2);
    p = -1;
    for i=1:N
        for j=1:N
            positions_ones = [];

            if i-1>0
                positions_ones(end+1) = (i-1-1)*N+j;
            end
            if j-1>0
                positions_ones(end+1) = (i-1)*N+j-1;
            end
            if j+1<=N
                positions_ones(end+1) = (i-1)*N+j+1;
            end
            if i+1<=N
                positions_ones(end+1) = (i-1+1)*N+j;
            end

            A((i-1)*N+j, positions_ones) = p; % set 1 to filtered positions
            A((i-1)*N+j, (i-1)*N+j) = w;
        end
    end
    A = sparse(A);
end
