function SaveRGBImagesForReport(imageName, imageRGB, elapsedTime, additionalInfo)
% Function that saves the composed Images in the "Output/" Folder for the
% Report 
% Author
%   Robin Melan
% Input
%   imageName 
%   imageRGB:           RGB Image
%   elapsedTime:        Runtime of the algorithm
%   additionalInfo:     Additional Info for the filename
%
% Example
%   SaveRGBImagesForReport('00125v', MxNx3, 10, 'with_bonus');

outputFolder = 'Output/';

%% Create 'Output/' Folder if it does not exist
if (exist(outputFolder,'file') == 0)
    mkdir(outputFolder);
end


%% Save Images in the 'Output/' Folder 
fileNamePath = sprintf('%s%s_%ss_%s.jpg',outputFolder, cell2mat(imageName),elapsedTime,additionalInfo);
imwrite(imageRGB,fileNamePath);

end