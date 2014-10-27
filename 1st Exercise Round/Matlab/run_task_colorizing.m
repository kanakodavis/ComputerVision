function run_task_colorizing()
%Function that starts the code for the Assignment 1: Colorizing Images
% Authors
%   * David Pfahler
%   * Matthias Gusenbauer
%   * Robin Melan

%constant array with names of the images (each image has 3 images in the
%containing folder which are not aligned (RGB)
imageNames = {'00125v';'00149v';'00153v';'00351v';'00398v';'01112v'};

for imageName = imageNames
    %% load images
    
    [R, G, B] = LoadRGBGlassPlateScans(imageName);
    
    %% align images automatically
    
    %TODO
    
    %% combine and display them 
    
    %TODO
    %imshow(R+G+B);
    
end

end