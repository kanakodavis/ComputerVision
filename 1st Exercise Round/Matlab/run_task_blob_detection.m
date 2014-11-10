function run_task_blob_detection()
%Function that starts the code for the Assignment 3: Scale-Invariant Blob
%Detection 
% Authors
%   * David Pfahler
%   * Matthias Gusenbauer
%   * Robin Melan

%constant array with names of the images
imageNames = {'Images/butterfly.jpg','Images/myimage.jpg'};
for imageName = imageNames
%% Load images

image = imread(imageName{1});

%% implement a LoG blob detector

scaleSpace = CreateScaleSpace(image, 10);
%TODO MAYBE do abs(scalespace) before max detection
[height, width, slice] = size(scaleSpace);

for x=1:height
    for y=1:width
        for z=1:slice
            if(IsMaximum(x, y, z))
                %TODO thresholding
                %need to find appropriate one
            end
        end
    end
end

%TODO draw circles
%radius is sigma * sqrt(2) -> maybe create sigma beforehand and feed to
%CreateScaleSpace


end

end