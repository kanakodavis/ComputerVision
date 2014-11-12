function [u] = kmeans_compute_cluster_centroids(X, k , r, u)
% Step 3 After all datapoints were assigned to their nearest cluster
% centroid (r) the cluster centroids must be computed new 
% Input
%   X : objects/image
%   k : selected k, representing the number of clusters
%   r : holding the assigned cluster for every object in X
%   u : holding the old values of the cluster centroids
%
% Output
%   u : returning the new values of the cluster centroids
%
% Author
%   Robin Melan
%
%

    for i = 1:k
        % Summiere alle x elemente wo r=k ist und dann dividiere sie durch
        % die summe der r = k
        % Nenner
        tmp = zeros(size(r));
        tmp(r==i) = 1;
        tmp(r~=i) = 0;
        nenner = sum(tmp);
        
        % Cannot devide by 0!
        if (nenner ~= 0)
            % Zähler
            tmp = zeros(size(r));
            tmp(r==i) = 1;
%             zaehler = [0 0 0];
            
            % Better Performance:
            X_col1 = X(:,1);
            X_col2 = X(:,2);
            X_col3 = X(:,3);
            
            u(i,1) = sum(tmp .* X_col1) / nenner;
            u(i,2) = sum(tmp .* X_col2) / nenner;
            u(i,3) = sum(tmp .* X_col3) / nenner;
            
%             for pixel = 1:size(X,1)
%                 % Multiply only if pixel is relevant
%                 if (tmp(pixel,1) ~= 0)
%                     zaehler(1) = zaehler(1) + tmp(pixel,1) * X(pixel,1);
%                     zaehler(2) = zaehler(2) + tmp(pixel,1) * X(pixel,2);
%                     zaehler(3) = zaehler(3) + tmp(pixel,1) * X(pixel,3);
%                 end
%             end

%             u(i,1) = zaehler(1) / nenner;
%             u(i,2) = zaehler(2) / nenner;
%             u(i,3) = zaehler(3) / nenner;
        end
    end

    
    
end