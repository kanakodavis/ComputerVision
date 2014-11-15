function [r] = kmeans_assign_datapoints(X,u)
% Step 2 After choosing random starting values for the cluster centroids,
% the objects (X) have to be assigned to their nearest cluster centroid
% which will be saved in r
% Input
%   X : objects/image
%   u : holding the old values of the cluster centroids
%
% Output
%   r : holds the assigned cluster value of every object of X
%
% Author
%   * Robin Melan
%   * David Pfahler
%


    r = zeros(size(X,1),1);
    k = size(u,1); % Number of clusters

    for i = 1:size(X)
        s = zeros(1,k);
        % Zeile - uZeile --> normalisieren --> sqr
        % Bsp:  D = 3;
        %       X(1,:) = 0 0.5020 0
        %       u(1,:) = 1    0   0
        for j = 1:k
            s(j) = norm(X(i,:) - u(j,:))^2;
        end
        % Minimum nehmen und r setzen
        [value,pos] = min(s);

        r(i,1) = pos;
    end

end