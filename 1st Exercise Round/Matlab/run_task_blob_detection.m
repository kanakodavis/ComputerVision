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

%%Init sigma for LOG convolution
sigmas = InitSigma(10);

%%Create scale space with LOG and sigmas
scaleSpace = CreateScaleSpace(image, sigmas);

%%Find maxima in scale space and threshold them
[height, width, slice] = size(scaleSpace);

xPos = [];
yPos = [];
rad = [];

for z=1:slice
    for y=1:width
        for x=1:height
            if(IsMaximum(scaleSpace, x, y, z)) %if is maximum - all pixels around == smaller
                
                if(scaleSpace(x, y, z) > 110) %do thresholding
                    xPos = [xPos x];
                    yPos = [yPos y];
                    tmpRad = sigmas(z) * sqrt(2);
                    rad = [rad tmpRad];
                end
            end
        end
    end
end

%%Draw circles onto image

%%%add path for draw circles function
addpath ./Functions

show_all_circles(image, yPos', xPos', rad'); %x and y swapped - TODO need to fix

rmpath ./Functions

end

end