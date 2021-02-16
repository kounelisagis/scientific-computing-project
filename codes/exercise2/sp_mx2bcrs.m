function [val,col_idx,row_blk] = sp_mx2bcrs(A,nb)
    
    n = length(A);
    nd = n/nb;

    val = zeros(nb,nb,0);
    col_idx = [];
    row_blk = NaN(1, nd+1);
    row_blk(1) = 1;

    for row_block=1:nd
        row_nnzb = 0;
        
        for col_block=1:nd
            row = (row_block-1)*nb + 1;
            col = (col_block-1)*nb + 1;
            B = A(row:row+nb-1,col:col+nb-1);  % B is the current block
            
            if nnz(B) ~= 0  % not a zero block
                val(:,:,end+1) = B;
                col_idx = [col_idx col_block];
                row_nnzb = row_nnzb + 1;
            end
        end
        
        row_blk(row_block+1) = row_blk(row_block) + row_nnzb;

    end
end
