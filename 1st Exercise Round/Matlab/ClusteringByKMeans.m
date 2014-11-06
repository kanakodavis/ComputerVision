%function [cluster_idx cluster_center] = ClusteringByKMeans(X,K)

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

% TODO change when finished
function ClusteringByKMeans
    %% Initialization TODO remove when finished
    imageName = {'future.jpg'};
    % declare the number of segments
    k = 3;
    % Load images
    fullPath = sprintf('Images/%s',cell2mat(imageName));
    I = im2double(imread(fullPath));
    nrows = size(I,1);
    ncols = size(I,2);
    x = reshape(I,nrows*ncols,3);

    imtool(I);
    %% My K Means
    
%     sample = zeros(20,3);
%     sample(1:10,1) = x(5600:5609,1);
%     sample(1:10,2) = x(5600:5609,2);
%     sample(1:10,3) = x(5600:5609,3);
%     sample(11:end,1) = x(56000:56009,1);
%     sample(11:end,2) = x(56000:56009,2);
%     sample(11:end,3) = x(56000:56009,3);
    sample = x;
    
    % Illustration VORHER
    figure, scatter3(sample(:,1),sample(:,2),sample(:,3), 'c'), hold on;
    scatter3(1,0,0,'r'); 
    scatter3(0,1,0,'g');
    scatter3(0,0,1,'b');
    title('VORHER');
    xlabel('x axis');
    ylabel('y axis');
    zlabel('z axis');
    hold off;   
    
    % 1. Coose random starting values for the centroids u
    u = eye(3);
    % u = [1,0,0];
    % u = [0,1,0];
    % u = [0,0,1];
    
    % 2. Assign all data points to their nearest cluster centroids (r is holding the solution)
    r = zeros(size(sample,1),1);
    
    
    for i = 1:size(sample)
        s = [0 0 0];
        s(1) = norm(sample(i,:) - u(1,:))^2;
        s(2) = norm(sample(i,:) - u(2,:))^2;
        s(3) = norm(sample(i,:) - u(3,:))^2;
        s;
        [Y,I] = min(s);
        
        r(i,1) = I;
    end
    r;
    
    % 3. Compute the new cluster centroids as the mean of all data points
    % assigned to that cluster:
    for i = 1:k
        % Summiere alle x elemente wo r=k ist und dann dividiere sie durch
        % die summe der r = k
        % Nenner
        tmp = zeros(size(r));
        tmp(r==i) = 1;
        tmp(r~=i) = 0;
        nenner = sum(tmp);
        if (nenner ~= 0)
            % Zähler
            tmp = zeros(size(r));
            tmp(r==i) = 1;
            zaehler = [0 0 0];
            for pixel = 1:size(sample,1)
                zaehler(1) = zaehler(1) + tmp(pixel,1) * sample(pixel,1);
                zaehler(2) = zaehler(2) + tmp(pixel,1) * sample(pixel,2);
                zaehler(3) = zaehler(3) + tmp(pixel,1) * sample(pixel,3);                     
            end

            zaehler;
            nenner;

            u(i,1) = zaehler(1) / nenner;
            u(i,2) = zaehler(2) / nenner;
            u(i,3) = zaehler(3) / nenner;
            u;
        end
    end
    
    % Illustration NACHHER
    figure, scatter3(sample(:,1),sample(:,2),sample(:,3), 'c'), hold on;
    scatter3(u(1,1),u(1,2),u(1,3),'r'); 
    scatter3(u(2,1),u(2,2),u(2,3),'g');
    scatter3(u(3,1),u(3,2),u(3,3),'b');
    title('NACHHER');
    xlabel('x axis');
    ylabel('y axis');
    zlabel('z axis');
    hold off;
    
    % K Means
    %[cluster_idx cluster_center] = kmeans(sample,k,'distance','sqEuclidean','Replicates',5);
    %sample;
    %cluster_idx;
    
    %% Displaying remove when finished
%     pixel_labels = reshape(cluster_idx,nrows,ncols);
%      segmented_images = cell(1,3);
%     % Creating tiles for three different colors 
%     rgb_label = repmat(pixel_labels,[1 1 3]);
% 
%     % Assigning clustered objects to array(segmented_image) 
%     for k = 1:k
%         color = I;
%         color(rgb_label ~= k) = 0;
%         segmented_images{k} = color;
%     end
% 
%     % displaying different cluster objects 
%     figure, imshow(segmented_images{1}), title('objects in cluster 1');
%     figure, imshow(segmented_images{2}), title('objects in cluster 2');
%     figure, imshow(segmented_images{3}), title('objects in cluster 3');
end