function run_task_colorizing()
%Function that starts the code for the Assignment 1: Colorizing Images
% Authors
%   * David Pfahler
%   * Matthias Gusenbauer
%   * Robin Melan

%% initialization
%constant array with names of the images (each image has 3 images in the
%containing folder which are not aligned (RGB)
imageNames = {'00125v','00149v','00153v','00351v','00398v','01112v','00882a'};
SearchSize = 15;

%for debug: TODO delete
<<<<<<< HEAD
%imageNames = {'00882a'};
=======
% tmp = {'00125v'};
>>>>>>> 8c9b4a243238840b8188c9925bb2f1a2e93f668f

for imageName = imageNames
    %% load images
    
    [R, G, B] = LoadRGBGlassPlateScans(imageName);
    
    %% align images automatically
    % Take time
    tic;
    
    G_aligned = FasterAlignWithNCCMetric(R,G,SearchSize);
    B_aligned = FasterAlignWithNCCMetric(R,B,SearchSize);
    R_aligned = R;
    
    elapsedTimeFast = num2str(toc);
    
    %% combine and display them 
<<<<<<< HEAD
    RGB = uint8(zeros([size(R_aligned) 3]));
    RGB(:,:,1) = R_aligned;
    RGB(:,:,2) = G_aligned;
    RGB(:,:,3) = B_aligned;
=======
    
    RGB = cat(3, R_aligned, G_aligned, B_aligned);
    %RGB(:,:,1) = R_aligned;
    %RGB(:,:,2) = G_aligned;
    %RGB(:,:,3) = B_aligned;
>>>>>>> 8c9b4a243238840b8188c9925bb2f1a2e93f668f
    figure;
    imshow(RGB);
    
    %% align images automatically
    % Take time
     tic
    
     BestMatchCircShift = AlignWithNCCMetric(R,G,SearchSize);
    	G_aligned = circshift( G , BestMatchCircShift );
     
     BestMatchCircShift = AlignWithNCCMetric(R,B,SearchSize);
    	B_aligned = circshift( B , BestMatchCircShift );
%     
     R_aligned = R;
     
     elapsedTimeSimple = num2str(toc);
     
%     %% combine and display them 
%    
     RGB2 = cat(3, R_aligned, G_aligned, B_aligned);
     %RGB2(:,:,1) = R_aligned;
     %RGB2(:,:,2) = G_aligned;
     %RGB2(:,:,3) = B_aligned;
%     figure;
%     imshow(RGB2);
     
     %% Save new Image with and without Correlation for the Report
          
     imageWithCorrBonus = RGB;
     imageWithCorr      = RGB2;
     imageWithoutCorr   = cat(3, R, G, B);
     SaveRGBImagesForReport(imageName, imageWithoutCorr, imageWithCorr, imageWithCorrBonus, elapsedTimeSimple, elapsedTimeFast);
    
end

end