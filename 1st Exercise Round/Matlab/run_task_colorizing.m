function run_task_colorizing()
%Function that starts the code for the Assignment 1: Colorizing Images
% Authors
%   * David Pfahler
%   * Matthias Gusenbauer
%   * Robin Melan

%constant array with names of the images (each image has 3 images in the
%containing folder which are not aligned (RGB)
images = {'00125v';'00149v';'00153v';'00351v';'00398v';'01112v'};

for I = images
    %% load images
    
    [R, G, B] = LoadRGBGlassPlateScans(images);
    
    %% align images automatically
    
    %% combine and display them 
    imshow(R+G+B);
    
end

end