matrices = {'Rajat/rajat04', gallery('wathen',10,20), 1+mod(9637,2892)};
matrices_names = {'Rajat/rajat04', 'wathen', 'Schenk\_ISEI/barrier2-11'};

for k=1:length(matrices)
    P = band_stats(matrices{k});

    % plot
    marker_step = 30;
    marker_size = 8;

    figure();
    p1 = plot(1:2:2*length(P(:,1))-1, P(:,1), '-bx', 'MarkerIndices', 1:marker_step:length(P(:,1)), 'MarkerSize', marker_size);
    hold on;
    p2 = plot(1:2:2*length(P(:,2))-1, P(:,2), '-ro', 'MarkerIndices', 1:marker_step:length(P(:,2)), 'MarkerSize', marker_size);
    hold off;
    title(strcat({'Band Stats - '}, matrices_names{k}));
    xlabel('Εύρος Ζώνης k');
    ylabel('rnnz και rerr για το A^{(k)}');
    legend([p1 p2],'rnnz','rerr');

end
