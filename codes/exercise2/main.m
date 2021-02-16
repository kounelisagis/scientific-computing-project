matrices = {'HB/arc130', 'Pajek/GD96_a'};

for k=1:length(matrices)
    A = full(ssget(matrices{k}).A);
    x = rand(length(A),1);
    y = rand(length(A),1);

    true_y = y + A*x;

    nb = 2;
    [val,col_idx,row_blk] = sp_mx2bcrs(A,nb);
    my_y = spmv_bcrs(y,val,col_idx,row_blk,x);

    norm(true_y - my_y)
end
