function [J] = kmeans_compute_J(image, r, u)
% In K-means clustering the cluster centroids uk (k = 1, .. , K) are
% computed as the mean of all data points with shortest distance to that
% centroid. To describe the assignment of data points to clusters, a binary
% indicator matrix r(n,k) is used. (e.g. k = 3, then r is an array of
% object/image size putting every object to one of the 3 clusters)
% J is then the objective function (distortion measure):
%
%
%  J = sum over objects size  (                                           )
%                               sum over k (                            ) 
%                                            r(n,k) * || xn - uk || ^ 2
%
% Input
%   image : (X) holds values of the image
%   r : holding the assigned cluster for every object in X
%   u : holding the old values of the cluster centroids
%   
% Output
%   J : value returning of the objective function (distortion measure)
%
% Author
%   * Robin Melan
%   * David Pfahler


J = 0;
k = size(u,1); % Number of clusters

% instade of having a runtime of O(|objects|*|k|) we simplify and gain
% performance out of it:

R = zeros(1,k);

for i = 1:k
    R(i) = norm(image-repmat(u(i,:),size(image,1),1))^2;
end

for i = 1:k
    tmp = zeros(size(r));
    tmp(r==i) = 1;
    
    %        r(n,k) *       || xn - uk ||     ^ 2
    for j = 1:k
        J = J + sum(tmp * R(j));
    end

end


%     % Eigentliche Berechnung
%     for n = 1:size(image,1)
%
%         for i = 1:k
%             tmp = zeros(size(r));
%             tmp(r==i) = 1;
%
%             %        r(n,k) *       || xn - uk ||     ^ 2
%             s(1) = tmp(n,1) * u1;
%             s(2) = tmp(n,1) * u2;
%             s(3) = tmp(n,1) * u3;
%
%             J = J + sum(s);
%         end
%     end

end