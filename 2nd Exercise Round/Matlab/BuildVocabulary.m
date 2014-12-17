function [ C ] = BuildVocabulary(folder, num_clusters)
% Function that builds a vocabulary of visual words by sampling many local
% features from the given training set.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Long description:
% Function that builds a vocabulary of visual words by sampling many local
% features from the given training set.(i.e. 100’s of thousands of
% features) and then clustering them with K-means. The number of K-means
% clusters num_clusters is the size of our vocabulary. For example, if
% num_clusters=50 then the 128 dimensional SIFT feature space is
% partitioned into 50 regions. For any new SIFT feature we observe, we can
% figure out which cluster it belongs to as long as we save the centroids
% of our original clusters. Those clusters are our visual word vocabulary.
%
% The function extracts dense SIFT features from all the images contained
% in the category subfolders of the general training folder (argument
% folder) and collect them for K-means clustering. For feature extraction
% we use the function vl_dsift. Please note that we do not necessarily need
% to extract a SIFT feature for every pixel for vocabulary creation, e.g.
% around 100 features per image are enough to "capture" the approximately
% correct distribution of SIFT features for the given image data. Hence,
% use the parameters 'Step' and 'Fast' for vl_dsift and optionally select
% only a random subset of features per image for the overall set (the
% function randsample might be helpful). To iterate all images, the
% function dir can be used. After all SIFT features have been collected,
% you should apply K-means clustering to find the visual words. vl_kmeans
% can be used here for performance reasons. The words are finally stored in
% the matrix C of size 128x num_clusters.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Authors
%   * David Pfahler
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Input
%  * folder: This is the folder that contains the training data. It 
% contains several folders wich have the names of the classes and contain 
% the images.
%  * num_clusters: The number of k-mean clusters is also the size of the 
% vocabulary. This means that the 128 dimensional SIFT feature space is 
% partitioned into this number of regions.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Output
%   C: Get the centroits of the clusters 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Example:
%   C = BuildVocabulary(folder, num_clusters);

%% Load the Images 
% Load the images from the given folder into a cell array and keep the
% name of the category.

[c_images,c_category_names] = GetInput(folder);

% The function extracts dense SIFT features from all the images contained
% in the category subfolders of the general training folder (argument
% folder) and collect them for K-means clustering. For feature extraction
% we use the function vl_dsift. Please note that we do not necessarily need
% to extract a SIFT feature for every pixel for vocabulary creation, e.g.
% around 100 features per image are enough to "capture" the approximately
% correct distribution of SIFT features for the given image data. Hence,
% use the parameters 'Step' and 'Fast' for vl_dsift and optionally select
% only a random subset of features per image for the overall set (the
% function randsample might be helpful). To iterate all images, the
% function dir can be used. After all SIFT features have been collected,
% you should apply K-means clustering to find the visual words. vl_kmeans
% can be used here for performance reasons. The words are finally stored in
% the matrix C of size 128x num_clusters.

C = 0;
end