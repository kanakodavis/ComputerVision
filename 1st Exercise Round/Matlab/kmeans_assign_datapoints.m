function [AssignedClusterValue] = kmeans_assign_datapoints(X,u)
% Step 2 After choosing random starting values for the cluster centroids,
% the objects (X) have to be assigned to their nearest cluster centroid
% which will be saved in r
% Input
%   X : objects/image
%   u : holding the old values of the cluster centroids
%
% Output
%   AssignedClusterValue : holds the assigned cluster value of every object of X
%
% Author
%   * Robin Melan
%   * David Pfahler
%


    NumDatapoints = size(X,1);
    NumClusters = size(u,1); % Number of clusters
    s = zeros(NumDatapoints,NumClusters); %Mean difference of the datapoints   
    for j = 1:NumClusters
        u_rep = repmat(u(j,:),NumDatapoints,1);
        s(:,j) = sum((X-u_rep).^2, 2);
    end
    
    [value,pos] = min(s,[],2);
     AssignedClusterValue = pos;

end