function [ C ] = BuildVocabulary(training_set, num_clusters)
%% Builds a vocabulary of visual words
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Authors
%   * David Pfahler
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Input
%  * training_set: This is the training data. It contains images and their
%  category names.
%  * num_clusters: The number of k-mean clusters is also the size of the 
% vocabulary. This means that the 128 dimensional SIFT feature space is 
% partitioned into this number of regions.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Output
%   C: The centroits of the clusters with size 128x num_clusters.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Example:
%   C = BuildVocabulary(training_set, num_clusters);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

num_features_per_image = 100;
num_features = size(training_set(:,1),1)*num_features_per_image;
features = zeros(128,num_features);
image_id = 1;
%% Get visual words
for c_I = training_set(:,1)'
    I = single(cell2mat(c_I));
    % collect dense SIFT features for faster feature extraction only 100
    % features get extracted per image.
    step = floor(min(size(I))/10);
    [f, d] = vl_dsift(I, 'Step', step, 'Fast');
    
    %Select only a random subset of features per image for the overall set
    chosen_random_features = randsample(size(d,2),num_features_per_image);
    
    % add the features of the current image to the feature space.
    features(:,1+(image_id-1)*100:image_id*100) = d(:,chosen_random_features);
    image_id = image_id + 1;
end

%% apply K-means clustering 
% to find the centeroits of the classification clustering
C = vl_kmeans(features,num_clusters);

end