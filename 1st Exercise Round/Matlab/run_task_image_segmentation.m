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
for imageName = imageNames
%% Load images
fullPath = sprintf('Images/%s',cell2mat(imageName));
I = imread(fullPath);

%% Implement the image segmentation
% kmeans: http://www.mathworks.in/matlabcentral/fileexchange/8379-kmeans-image-segmentation/content/kmeans.m

%TODO 

%% Visualize the results
%by coloring all pixels of a cluster with their mean color values. 

%TODO 

end

end