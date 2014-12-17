function run_task_scene_recognition()
%run_task_scene_recognition Performs scene recognition with bag of visual
% words on the given image classes

%% initiate constants

% The number of k-mean clusters is also the size of out vocabulary. This
% means that the 128 dimensional SIFT feature space is partitioned 
% into 50 regions
num_clusters = 50; 

% This is the folder that contains the training data. It contains several
% folders wich have the names of the classes and contain the images.
folder = 'Material\train';

%% Step 1: build a vocabulary of visual words.

% Get the centroits of the clusters 
C = BuildVocabulary(folder, num_clusters);

%% Step 2: build a feature representation for every image in the training set

[training, group] = BuildKNN(folder,C);

%% Step 3: classify all the images of the test set

conf_matrix = ClassifyImages(folder,C,training,group);





end

