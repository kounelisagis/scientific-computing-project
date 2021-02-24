function [y] = spmv_bcrs(y,val,col_idx,row_blk,x)

    n = length(x);
    nd = length(row_blk)-1;
    nb = n/nd;

    for block_row = 1:nd
        row = (block_row-1)*nb+1;

        for k = row_blk(block_row):row_blk(block_row+1)-1
            block_col = col_idx(k);
            col = (block_col-1)*nb+1;

            y(row:row+nb-1) = y(row:row+nb-1) + val(:,:,k) * x(col:col+nb-1);
        end
    end
end
