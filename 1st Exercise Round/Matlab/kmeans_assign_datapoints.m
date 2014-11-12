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
%   Robin Melan
%


    r = zeros(size(X,1),1);

    for i = 1:size(X)
        s = [0 0 0];
        % Zeile - uZeile --> normalisieren --> sqr
        % Bsp:  D = 3;
        %       X(1,:) = 0 0.5020 0
        %       u(1,:) = 1    0   0
        s(1) = norm(X(i,:) - u(1,:))^2;
        s(2) = norm(X(i,:) - u(2,:))^2;
        s(3) = norm(X(i,:) - u(3,:))^2;
        % Minimum nehmen und r setzen
        [value,pos] = min(s);

        r(i,1) = pos;
    end

end