% 3.1
A = ssget('HB/jgl009').A;
k = 4;
G = construct_tensor(A, k);

% 3.2
i = 2; j = 7;
fiber_sum1 = collapse(G(i,j,:));
fiber_sum2 = collapse(G(j,i,:));
sum1 = fiber_sum1 + fiber_sum2;

% 3.3
all_fiber_sums = double( collapse(G, 3) );
sum2 = all_fiber_sums(i,j) + all_fiber_sums(j,i);
