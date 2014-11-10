function run_task_blob_detection()
%Function that starts the code for the Assignment 3: Scale-Invariant Blob
%Detection 
%K-means Clustering
% Authors
%   * David Pfahler
%   * Matthias Gusenbauer
%   * Robin Melan

%constant array with names of the images
imageNames = {'butterfly.jpg','myimage.jpg'};
for imageName = imageNames
%% Load images

image = imread(imageName);

%% implement a LoG blob detector

scaleSpace = CreateScaleSpace(image, 10);

%TODO maximum thresholding

end

end