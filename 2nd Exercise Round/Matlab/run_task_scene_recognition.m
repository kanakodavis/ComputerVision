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
[training_set , category_names] = GetInput('Material\train');

% The same for the test folder:
test_set = GetInput('Material\test');


%% Step 1: build a vocabulary of visual words.

C = BuildVocabulary(training_set, num_clusters);

%% Step 2: build a feature representation for every image in the training set

[training, group] = BuildKNN(training_set,C);

%% Step 3: classify all the images of the test set

conf_matrix = ClassifyImages(test_set,C,training,group);

%% stuff
conf_matrix = conf_matrix / max(sum(conf_matrix));

%% Step 4: Visualize the results

figure;
imagesc(conf_matrix);
colormap(flipud(gray));
textStrings = num2str(conf_matrix(:),'%0.2f');
textStrings = strtrim(cellstr(textStrings)); 
numCategories = size(unique(group),1);
[x,y] = meshgrid(1:numCategories);   %# Create x and y coordinates for the strings
hStrings = text(x(:),y(:),textStrings(:),...      %# Plot the strings
                'HorizontalAlignment','center');
midValue = mean(get(gca,'CLim'));  %# Get the middle value of the color range
textColors = repmat(conf_matrix(:) > midValue,1,3);  %# Choose white or black for the
                                             %#   text color of the strings so
                                             %#   they can be easily seen over
                                             %#   the background color
set(hStrings,{'Color'},num2cell(textColors,2));  %# Change the text colors

set(gca,'XTick',1:numCategories,...                         %# Change the axes tick marks
        'XTickLabel',category_names,...  %#   and tick labels
        'YTick',1:numCategories,...
        'YTickLabel',category_names,...
        'TickLength',[0 0]);
end

