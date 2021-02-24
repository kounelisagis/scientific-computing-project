function y = myMV(z)
    N = sqrt(length(z));
    global w
    y = w*z;
    p = -1;
    for j=2:length(z)
        if mod(j-1,N) ~= 0
            y(j) = y(j)+z(j-1)*p;
        end
    end
    
    for j=1:length(z)-1
        if mod(j,N) ~= 0
            y(j) = y(j)+z(j+1)*p;
        end
    end

    for j=N+1:length(z)
        y(j) = y(j)+z(j-N)*p;
    end
    
    for j=1:length(z)-N
        y(j) = y(j)+z(j+N)*p;
    end

end
