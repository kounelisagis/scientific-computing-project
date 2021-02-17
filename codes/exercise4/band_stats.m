function P = band_stats(mxid)

    if isnumeric(mxid) && size(mxid,1)>1 && size(mxid,2)>1  % matrix
        A = mxid;
    elseif ischar(mxid) || (isnumeric(mxid) && length(mxid)==1 && rem(mxid,1)==0) % string or integer
        try
            A = ssget(mxid).A;
        catch
            error('Error! mxid not found.')
        end
        if isnumeric(mxid)
            [m,n] = size(A);
            A = A(1:min([m,n,1000]),1:min([m,n,1000]));
        end
    else
        error('Error! mxid must be string, integer or matrix.')
    end

    n = length(A);
    A_band = diag(diag(A));  % contains the main diagonal
    
    rnnz = nnz(A_band)/nnz(A);
    rerr = norm(A-A_band,'fro')/norm(A,'fro');

    P = zeros(n, 2);  % 1st column rnnz, 2nd column rerr
    P(1,:) = [rnnz rerr];
    
    for k=1:n-1
    	A_band = A_band + diag(diag(A,k), k) + diag(diag(A,-k), -k);
        rnnz = nnz(A_band)/nnz(A);
        rerr = norm(A-A_band,'fro')/norm(A,'fro');
        P(k+1,:) = [rnnz rerr];
    end

end
