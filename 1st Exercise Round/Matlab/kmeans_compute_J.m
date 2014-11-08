function [J] = kmeans_compute_J(image, k, r, u)
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
%   k : selected k, representing the number of clusters
%   r : holding the assigned cluster for every object in X
%   u : holding the old values of the cluster centroids
%   
% Output
%   J : value returning of the objective function (distortion measure)
%
% Author
%   Robin Melan


J = 0;

% instade of having a runtime of O(|objects|*|k|) we simplify and gain
% performance out of it:

a = image(:,1) - u(1,1);
b = image(:,2) - u(1,2);
c = image(:,3) - u(1,3);
d = [a b c];

u1 = norm(d)^2;

a = image(:,1) - u(2,1);
b = image(:,2) - u(2,2);
c = image(:,3) - u(2,3);
d = [a b c];

u2 = norm(d)^2;

a = image(:,1) - u(2,1);
b = image(:,2) - u(2,2);
c = image(:,3) - u(2,3);
d = [a b c];

u3 = norm(d)^2;

for i = 1:k
    tmp = zeros(size(r));
    tmp(r==i) = 1;
    
    %        r(n,k) *       || xn - uk ||     ^ 2
    J = J + sum(tmp * u1);
    J = J + sum(tmp * u2);
    J = J + sum(tmp * u3);

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