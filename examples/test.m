% NOTE: this script should be run with FIt-SNE directory set as current

% Generate a toy dataset

dim = 3;
sigma_0 = .0001;
cluster_num = 2;
cluster_size = 1E3;

X_clusters = [];
col_clusters = repmat(1:cluster_num,cluster_size,1);
col_clusters = col_clusters(:);

for i = 1:cluster_num
    X_clusters = [X_clusters; mvnrnd(rand(dim,1)', diag(sigma_0*ones(dim,1)), cluster_size)];
end

N_clusters = size(X_clusters,1);

figure(19988)
subplot(121)
scatter3(X_clusters(:,1), X_clusters(:,2), X_clusters(:,3),10, col_clusters, 'filled');
title('Original Data')

% Run t-SNE

clear opts
opts.stop_lying_iter = 2E2;
opts.max_iter = 400;
opts.start_late_exag_iter = 300;
opts.late_exag_coeff = 6;
opts.rand_seed = -1;

cluster_firstphase = fast_tsne(X_clusters, opts);

subplot(122)
scatter(cluster_firstphase(:,1), cluster_firstphase(:,2), 10, col_clusters, 'filled');
title('After t-SNE')
colormap(lines(cluster_num))
