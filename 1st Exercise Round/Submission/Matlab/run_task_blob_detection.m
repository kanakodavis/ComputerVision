function run_task_blob_detection()
%Function that starts the code for the Assignment 3: Scale-Invariant Blob
%Detection 
% Authors
%   * David Pfahler
%   * Matthias Gusenbauer
%   * Robin Melan

%variables for stem plot of LOG response
sigmas = 0;
smallImResp = 0;
bigImResp = 0;

for doHalf=0:1
    %constant array with names of the images
    imageNames = {'Images/butterfly.jpg','Images/matrix_test_contr.jpg'};
    for imageName = imageNames
    %% Load images
    image = imread(imageName{1});

    %%%Half image in size and then run detection
    if doHalf
       image = imresize(image, 0.5); 
    end

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

    %%Plot the responses of a keypoint
    %%%(manually)checked that in both image sizes same point
    [~, position] = max(rad); 

    %%%Create vector of matrix for plot of LOG response
    if doHalf
       smallImResp = reshape(scaleSpace(xPos(position), yPos(position), :), 1, 10); 
    else
       bigImResp = reshape(scaleSpace(xPos(position), yPos(position), :), 1, 10);
    end


    %%Draw circles onto image

    %%%add path for draw circles function
    addpath ./Functions

    show_all_circles(image, yPos', xPos', rad'); %x and y swapped - TODO need to fix

    rmpath ./Functions

    end

end

PlotLOGResponses(sigmas, smallImResp, bigImResp);

end