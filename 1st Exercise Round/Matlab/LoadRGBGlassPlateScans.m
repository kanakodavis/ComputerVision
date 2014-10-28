function [R G B] = LoadRGBGlassPlateScans( imageName )

%Function that starts the code for the Assignment 1: Colorizing Images
% Authors
%   * David Pfahler
%   * Matthias Gusenbauer
%   * Robin Melan
% Input
%  imageName: The name of the image file
% Output
%   R,G,B: The 3 image files as matrices
% Example:
%   [R G B] = LoadRGBGlassPlateScans( 'image name' );

RGB_names = {'_R';'_G';'_B'};
RGB = cell(3,1);
for i = 1:3
   fullPath = sprintf('Images/%s%s.jpg',cell2mat(imageName),cell2mat(RGB_names(i)));
   RGB(i) = {imread(fullPath)};
end

R = cell2mat(RGB(1));
G = cell2mat(RGB(2));
B = cell2mat(RGB(3));
%TODO

end