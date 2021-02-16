function [y] = spmv_bcrs(y,val,col_idx,row_blk,x)

    n = length(row_blk)-1;
    nb = length(x)/n;

    for i = 1:n
        for j = row_blk(i):row_blk(i+1)-1
            real_row = (i-1)*nb+1;
            real_col = (col_idx(j)-1)*nb+1;
            y(real_row:real_row+nb-1) = y(real_row:real_row+nb-1) + val(1:nb,(j-1)*nb+1:j*nb) * x(real_col:real_col+nb-1);
        end
    end

end
