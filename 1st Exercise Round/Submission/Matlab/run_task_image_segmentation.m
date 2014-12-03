function run_task_image_segmentation()
%Function that starts the code for the Assignment 2: Image Segmentation by
%K-means Clustering
% Authors
%   * David Pfahler
%   * Matthias Gusenbauer
%   * Robin Melan

%% initialization
%constant array with names of the images
imageNames = {'simple.png', 'future.jpg', 'mm.jpg'};
tmp = {'future.jpg'};
% declare the number of segments
k = 3;

for imageName = imageNames
    %% Load images
    fullPath = sprintf('Images/%s',cell2mat(imageName));
    I = im2double(imread(fullPath));

    % display the original image
    %figure, imshow(I), title('Original Image');
    
    %% Kmeans image segmentation with D = 3
    
    nrows = size(I,1);
    ncols = size(I,2);
    x = reshape(I,nrows*ncols,3);
    % For Comparing reasons:
    [cluster_idx2 cluster_center2] = ClusteringByKMeans(x,k);
    
    kmeans_compute_J(x, cluster_idx2, cluster_center2);
    
    %% Kmeans image segmentation with D = 3
    
    [X1,X2] = ndgrid(1:nrows,1:ncols);
    x = [reshape(I,nrows*ncols,3) X1(:) X2(:)];
    x = x ./ repmat(max(x),nrows*ncols,1);
    
    [cluster_idx cluster_center] = ClusteringByKMeans(x,k);
    
    kmeans_compute_J(x, cluster_idx, cluster_center);
    
    
    %% Visualize the results
    %by coloring all pixels of a cluster with their mean color values. 
    
    % Reshaping and showing the clusters 
    pixel_labels = reshape(cluster_idx,nrows,ncols);
    figure, imshow(pixel_labels,[]), title('image labeled by cluster index');
    
    % creating three element array
    segmented_images = cell(1,3);
    % Creating tiles for three different colors 
    rgb_label = repmat(pixel_labels,[1 1 3]);

    % Assigning clustered objects to array(segmented_image) 
    for k = 1:k
        color = I;
        color(rgb_label ~= k) = 0;
        segmented_images{k} = color;
    end

    % displaying different cluster objects 
    figure, imshow(segmented_images{1}), title('objects in cluster 1');
    figure, imshow(segmented_images{2}), title('objects in cluster 2');
    figure, imshow(segmented_images{3}), title('objects in cluster 3');
    SaveRGBImagesForReport(imageName,segmented_images{1},'_D_5','_Cluster 1');
    SaveRGBImagesForReport(imageName,segmented_images{2},'_D_5','_Cluster 2');
    SaveRGBImagesForReport(imageName,segmented_images{3},'_D_5','_Cluster 3');
    
    %by coloring all pixels of a cluster with their mean color values. 
    
    % Reshaping and showing the clusters 
    pixel_labels = reshape(cluster_idx2,nrows,ncols);
    figure, imshow(pixel_labels,[]), title('image labeled by cluster index');
    
    % creating three element array
    segmented_images = cell(1,3);
    % Creating tiles for three different colors 
    rgb_label = repmat(pixel_labels,[1 1 3]);

    % Assigning clustered objects to array(segmented_image) 
    for k = 1:k
        color = I;
        color(rgb_label ~= k) = 0;
        segmented_images{k} = color;
    end

    % displaying different cluster objects 
    figure, imshow(segmented_images{1}), title('objects in cluster 1 - D = 3');
    figure, imshow(segmented_images{2}), title('objects in cluster 2 - D = 3');
    figure, imshow(segmented_images{3}), title('objects in cluster 3 - D = 3');
    SaveRGBImagesForReport(imageName,segmented_images{1},'_D_3','_Cluster 1');
    SaveRGBImagesForReport(imageName,segmented_images{2},'_D_3','_Cluster 2');
    SaveRGBImagesForReport(imageName,segmented_images{3},'_D_3','_Cluster 3');

end

end