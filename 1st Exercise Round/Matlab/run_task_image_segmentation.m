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

for imageName = tmp
    %% Load images
    fullPath = sprintf('Images/%s',cell2mat(imageName));
    I = im2double(imread(fullPath));

    % display the original image
    figure, imshow(I), title('Original Image');
    
    %% Implement the image segmentation
    % kmeans: http://www.mathworks.in/matlabcentral/fileexchange/8379-kmeans-image-segmentation/content/kmeans.m
    
    % Creating color transformation from sRGB to L*a*b 
    cform = makecform('srgb2lab');
    % Applying above color transform to the sRGB image 
    lab_he = applycform(I,cform); 
    % Converting into double and taking only the 'a*' and 'b*' values, since they hold the color information 
    ab = double(lab_he(:,:,2:3));
    % obtaining rows and columns of transformed image 
    nrows = size(ab,1);
    ncols = size(ab,2);
    % Reshaping image taking each value column wise to have my objects {x1,x2,...xN} 
    ab = reshape(ab,nrows*ncols,2);
    % No of clusters to be created with k iterations 
    [cluster_idx cluster_center] = kmeans(ab,k,'distance','sqEuclidean','Replicates',5); 
    
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

end

end