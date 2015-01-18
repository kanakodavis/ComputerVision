function [training, group] = BuildKNN(training_set,C)
%% Build KNN
% The next step is to build a feature representation for every image in the
% training set that can be used for the classification of new images later
% on. An image is represented by the normalized histogram of visual words,
% which means that all SIFT features of an image are assigned to visual
% words and the number of occurrences of every word is counted. As we will
% use the Matlab function knnclassify, the output of BuildKNN should be a
% matrix training of feature points, where the rows represent the 800
% images of the training set, as well as the vector group that indicates
% the class labels of the 800 images. For convenience, one can simply take
% the directory index provided by the function dir for class labeling. In
% this step the SIFT features should be more densely sampled than before,
% thus the step size should be 1 or 2. In order to build a histogram of
% SIFT words the functions knnsearch and histc can be used.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Authors
%  * David Pfahler
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Input
%  * training_set: This is the training data. It contains images and their
%  category names.
%  * C: The centroits of the clusters of the visual words
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Output
%  * training: The feature points of each image which is the visual word
%  histogram of an image
%  * group: indicates the class labels
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Example:
%  * [training, group] = BuildKNN(training_set,C)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    group = cell2mat(training_set(:,2));
    training = zeros(size(training_set,1),size(C,2));
    step = 1; % or 1
    I_id = 1;
    %% Get the SIFT features for every image but more densely
    for c_I = training_set(:,1)'
        I = single(cell2mat(c_I));
        [f , d] = vl_dsift(I,'Step', step , 'Fast');
        
        % Build histogramm which is the bag of visual words
        nearest_cluster = knnsearch(C',double(d'));
        training(I_id,:) = histc(nearest_cluster,1:size(C,2))';
        I_id = I_id + 1;
    end
end