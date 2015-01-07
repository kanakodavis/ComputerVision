function conf_matrix = ClassifyImages(test_set,C,training,group)
%% Classify the test data set
% The last step is to classify all the images of the test set to
% investigate the classification power of the bag of visual words model for
% our classification task. The function is similar to BuildKNN but this
% time the visual word histogram of an image is used for actually
% classifying it by means of the Matlab function knnclassify (e.g. k = 3)
% and the previously learned training features and class labels group. The
% final result is stored in the confusion matrix conf_matrix whose elements
% at position (i; j) indicate how often an image with class label i is
% classified to the class with label j.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Authors
%   * David Pfahler
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Input
%   * test_set: This is the test data. It contains images and their
%   category names.
%   * C: The centroits of the clusters of the visual words
%   * training: The feature points of each image which is the visual word
%   histogram of an image
%   * group: indicates the class labels of the training data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Output
%   * conf_matrix: matrix (num_classes x num_classes) indicate how often an
%   image with class label i is classified to the class with label j.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Example:
%   conf_matrix = ClassifyImages(test_set,C,training,group)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

test_group = cell2mat(test_set(:,2));
test = zeros(size(test_set,1),size(C,2));
step = 2; % or 1
I_id = 1;
conf_matrix = zeros(size(unique(group),1));

%% Get the SIFT features for every image but more densely
for c_I = test_set(:,1)'
    I = single(cell2mat(c_I));
    [f , d] = vl_dsift(I,'Step', step , 'Fast');

    % Build histogramm which is the bag of visual words
    nearest_cluster = knnsearch(C',double(d'));
    test(I_id,:) = histc(nearest_cluster,1:size(C,2))';
    I_id = I_id + 1;
end

%% Actual classification

class = knnclassify(test,training,group,3);

%% Build the conf_matrix
for i = unique(group)'
    current_class = class(test_group==i);
    [a,b]=hist(current_class,unique(current_class));
    conf_matrix(i,b)=a;
end
%% normalize confusion matrix
%conf_matrix = conf_matrix/max(max(conf_matrix));

end