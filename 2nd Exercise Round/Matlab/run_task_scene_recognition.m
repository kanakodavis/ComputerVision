function run_task_scene_recognition()
%run_task_scene_recognition Performs scene recognition with bag of visual
% words on the given image classes

%% initiate constants

% The number of k-mean clusters is also the size of out vocabulary. This
% means that the 128 dimensional SIFT feature space is partitioned 
% into 50 regions
num_clusters = 50; 

% Load the images from the given folder into a cell array and keep the
% name of the category.
training_set = GetInput('Material\train');

% The same for the test folder:
[test_set, category_names_test] = GetInput('Material\test');

% And for the pictures we made:
[own_set, category_names_own] = GetInput('Material\own');


%% Step 1: build a vocabulary of visual words.

C = BuildVocabulary(training_set, num_clusters);

%% Step 2: build a feature representation for every image in the training set

[training, group] = BuildKNN(training_set,C);

%% Step 3: classify all the images of the test set

conf_matrix_test = ClassifyImages(test_set,C,training,group);
conf_matrix_own = ClassifyImages(own_set,C,training,group);

%% Step 4: Visualize the results

VisualiueConfMatrix(conf_matrix_test,group,category_names_test)
VisualiueConfMatrix(conf_matrix_own,group,category_names_own)


end

