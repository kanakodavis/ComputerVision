function [cluster_idx cluster_center] = ClusteringByKMeans(X,K)

%Function that does the Color Image Segmentation by the K-means Clustering
% Authors
%   * Robin Melan
% Input
%   X: The Image in Format objects and its dimension D so (rows*cols,D)
%   K: defines the number of clustering, which is defines beforhand
% Output
%   cluster_idx: matrix of size (rows*cols,1)- RGB-pixel to certain cluster
%   cluster_center: returns centroids
%

%% TODO
% 1) get rid of the unnecessary comments, 
% 2) replace sample for X and k for K,
% 3) find better performance for Step 2,3
% 4) do K Means for 5 Dimnesions

    %% Just for Debbuging and Testing purposes
%     
%     sample = zeros(20,3);
%     sample(1:10,1) = x(5600:5609,1);
%     sample(1:10,2) = x(5600:5609,2);
%     sample(1:10,3) = x(5600:5609,3);
%     sample(11:end,1) = x(56000:56009,1);
%     sample(11:end,2) = x(56000:56009,2);
%     sample(11:end,3) = x(56000:56009,3);
    sample = X;
    k = K;
    
    % Result that I should get:
    %[cluster_idx cluster_center] = kmeans(sample,k,'distance','sqEuclidean','Replicates',5);

    
    %% 1. Coose random starting values for the centroids u
    u = eye(size(sample,2));
    
%     % Illustration VORHER
%     figure, %scatter3(sample(:,1),sample(:,2),sample(:,3), 'c'),
%     scatter3(u(1,1),u(1,2),u(1,3),'r'); hold on;
%     scatter3(u(2,1),u(2,2),u(2,3),'g');
%     scatter3(u(3,1),u(3,2),u(3,3),'b');
%     title('VORHER');
%     xlabel('x axis');
%     ylabel('y axis');
%     zlabel('z axis');
%     hold off;   
       
    % Set J_Old to 0 to initialize it 
    J_Old = 0;
    J_New = -1;

    % Deside how often to loop through the image 
while (J_New < J_Old)
    %% 2. Assign all data points to their nearest cluster centroids (r is holding the solution)
    r = kmeans_assign_datapoints(sample,u);
    
    
    %% To Compute J only once every iteration except for first time, after
    % one iteration J_Old becomes J_New and after J_New gets computed, the
    % while expression proves if necessary to continue
    J_Old = J_New;
    if (J_Old == -1)
        % Compute old J Value to compare it with the New J afterwards
        J_Old = kmeans_compute_J(sample, k, r, u);
    end
    
    
    %% 3. Compute the new cluster centroids as the mean of all data points
    % assigned to that cluster:
    u = kmeans_compute_cluster_centroids(sample, k, r, u);
    
    
    %% 4 Compute J and check for convergence. For this purpose, compute the
    % ratio between the old and new J. If the ratio lies under a given
    % threshold, terminate the clustering, otherwise go to point 2
    J_New = kmeans_compute_J(sample, k, r, u);
    
    
%     % Illustration NACHHER
%     figure, %scatter3(sample(:,1),sample(:,2),sample(:,3), 'c'), 
%     scatter3(u(1,1),u(1,2),u(1,3),'r'); hold on;
%     scatter3(u(2,1),u(2,2),u(2,3),'g');
%     scatter3(u(3,1),u(3,2),u(3,3),'b');
%     title('NACHHER');
%     xlabel('x axis');
%     ylabel('y axis');
%     zlabel('z axis');
%     hold off;
        
end % end of Iterations
    
    cluster_idx    = r;
    cluster_center = u;
    
end