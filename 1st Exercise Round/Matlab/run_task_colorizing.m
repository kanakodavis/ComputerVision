function run_task_colorizing()
%Function that starts the code for the Assignment 1: Colorizing Images
% Authors
%   * David Pfahler
%   * Matthias Gusenbauer
%   * Robin Melan

%% initialization
%constant array with names of the images (each image has 3 images in the
%containing folder which are not aligned (RGB)
imageNames = {'00125v','00149v','00153v','00351v','00398v','01112v'};
SearchSize = 15;

%for debug: TODO delete
%imageNames = {'01112v'};

for imageName = imageNames
    %% load images
    
    [R, G, B] = LoadRGBGlassPlateScans(imageName);
    
    %% align images automatically
    
    
    G_aligned = FasterAlignWithNCCMetric(R,G,SearchSize);
    B_aligned = FasterAlignWithNCCMetric(R,B,SearchSize);
    R_aligned = R;
    
    %% combine and display them 
    
    RGB(:,:,1) = R_aligned;
    RGB(:,:,2) = G_aligned;
    RGB(:,:,3) = B_aligned;
    figure;
    imshow(RGB);
    
    %% align images automatically
    
%     BestMatchCircShift = AlignWithNCCMetric(R,G,SearchSize);
%    	G_aligned = circshift( G , BestMatchCircShift );
%     
%     BestMatchCircShift = AlignWithNCCMetric(R,B,SearchSize);
%    	B_aligned = circshift( B , BestMatchCircShift );
%     
%     R_aligned = R;
%     
%     %% combine and display them 
%     
%     RGB(:,:,1) = R_aligned;
%     RGB(:,:,2) = G_aligned;
%     RGB(:,:,3) = B_aligned;
%     figure;
%     imshow(RGB);
    
end

end