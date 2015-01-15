function [ c_images , c_categories] = GetInput(folder)
%% Loads the categories
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Authors
%  * David Pfahler
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Input
%  * folder: This is the folder that contains the training data. It
%  contains several folders wich have the names of the classes and contain
%  the images.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% OUTPUT:
%  * c_images ... cell matrix that contains the loaded images of the given
%  folder and the name of the category of each image of the folder.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('Loading Images...');

currentDir = pwd;
base_listing = dir(folder);
cd(folder);
c_images = cell(0,2);
c_categories = cell(0,1);
skipped = 0;
% open each directory and load all images from that directory.
for i = 1 : size( base_listing, 1 )
    % if it is a directory go into it.
    if base_listing( i ).isdir == 1 && ~strcmpi(base_listing( i ).name,'.') && ~strcmpi(base_listing( i ).name,'..')
       current_listing = dir(base_listing(i).name);
       
       % remove directories . and ..
       current_listing = current_listing(~[current_listing.isdir]);
       
       % jump into the directory
       cd(base_listing(i).name);
       num_images = size(current_listing, 1 ); 
       c_current_images = cell(num_images,2);
       
       for j = 1 : num_images
         % read the image
         image = imread ( [current_listing( j ).name ]);
         
         % if it is rgb convert it to grayscale
         if size(image, 3) == 3
             c_current_images{j,1} = rgb2gray(image);
         else
             c_current_images{j,1} = image;
         end
         
         c_current_images{j,2} = i-skipped;
       end
       c_images = [c_images; c_current_images];
       c_categories = [c_categories; base_listing(i).name];
       cd('..');
    else
        skipped = skipped +1;
    end
end

%% Navigate back
cd(currentDir);

disp('Loading Images finished');

end
