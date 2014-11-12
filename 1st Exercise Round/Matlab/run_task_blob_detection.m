function run_task_blob_detection()
%Function that starts the code for the Assignment 3: Scale-Invariant Blob
%Detection 
% Authors
%   * David Pfahler
%   * Matthias Gusenbauer
%   * Robin Melan

%constant array with names of the images
imageNames = {'Images/butterfly.jpg','Images/matrix_test.jpg'};
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

%performance improvement notes:
%http://www.mathworks.com/matlabcentral/answers/86900-how-to-find-all-neighbours-of-an-element-in-n-dimensional-matrix
%http://www.mathworks.com/matlabcentral/fileexchange/29330-neighbour-points-in-a-matrix
%check ind2sub() method for linear indexing -> only one for and then get
%indices
%read: http://blogs.mathworks.com/steve/2007/03/28/neighbor-indexing/
%read on memory optimization: http://www.mathworks.de/company/newsletters/articles/programming-patterns-maximizing-code-performance-by-optimizing-memory-access.html

for z=1:slice
    for y=1:width
        for x=1:height
            if(IsMaximum(scaleSpace, x, y, z)) %if is maximum - all pixels around == smaller
                
                if(scaleSpace(x, y, z) > 110) %do thresholding and store parameters for line drawing
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