function run_task_colorizing()
%Function that starts the code for the Assignment 1: Colorizing Images
% Authors
%   * David Pfahler
%   * Matthias Gusenbauer
%   * Robin Melan

%% initialization
%constant array with names of the images (each image has 3 images in the
%containing folder which are not aligned (RGB)
imageNames = ...
{'00125v','00149v','00153v','00351v','00398v','01112v','00882a','00245a','00876a','01043a','01251a'}; % all images
%{'01251a'}; %newest image
%{'00882a','00245a','00876a','01043a'}; % The Big images
%{'00153v'}; % the problem image
%{'00125v','00149v','00153v','00351v','00398v','01112v'}; %the small images
%{'00125v','00149v','00153v','00351v','00398v','01112v','00882a','00245a','00876a','01043a','01251a'}; % all images

for imageName = imageNames
    %% load images
    
    [R, G, B] = LoadRGBGlassPlateScans(imageName);
    imageWithoutCorr   = cat(3, R, G, B);
    
    %% align images automatically
    % Take time
    tic;
    
    % The misalignment of the images is at a maximum of 5% (Just an
    % assumption)
    SearchSize = floor(min(size(R))/20);
    
    G_aligned = FasterAlignWithNCCMetric(R,G,SearchSize);
    B_aligned = FasterAlignWithNCCMetric(R,B,SearchSize);
    R_aligned = R;
    
    elapsedTimeFast = num2str(toc);
    
    % combine and display them 
    RGB = cat(3, R_aligned, G_aligned, B_aligned);
    figure;
    imshow(RGB);
    imageWithCorrBonus = RGB;
    
    if SearchSize < 20
    
        tic
        G_aligned = circshift( G , AlignWithNCCMetric(R,G,SearchSize) );
        B_aligned = circshift( B , AlignWithNCCMetric(R,B,SearchSize) );  
        R_aligned = R;

        elapsedTimeSimple = num2str(toc);

        % combine and display them 
        RGB2 = cat(3, R_aligned, G_aligned, B_aligned);

        figure;
        imshow(RGB2);

        % Save new Image with and without Correlation for the Report
       
        imageWithCorr      = RGB2;
        SaveRGBImagesForReport(imageName, imageWithCorr, elapsedTimeSimple, 'without_bonus');

        
    end
    SaveRGBImagesForReport(imageName, imageWithoutCorr, '', 'unaligned');
    SaveRGBImagesForReport(imageName, imageWithCorrBonus, elapsedTimeFast, 'with_bonus');
    
end

end