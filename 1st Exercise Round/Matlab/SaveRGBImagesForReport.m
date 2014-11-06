function SaveRGBImagesForReport(imageName, imageWithoutCorr, imageWithCorr, imageWithCorrBonus, elapsedTimeSimple, elapsedTimeFast)
% Function that saves the composed Images in the "Output/" Folder for the
% Report 
% Author
%   Robin Melan
% Input
%   imageName 
%   imageWithCorrBonus: RGB Image with the Bonus Correlation
%   imageWithCorr:      RGB Image with simple Correlation
%   imageWithoutCorr:   RGB Image with any correlation
%
%   elapsedTimeSimple:  Runtime of the Simple
%   elapsedTimeFast:    Runtime of the Bonus Task
%
% Example
%   SaveRGBImagesForReport('00125v', MxNx3, MxNx3, MxNx3);

outputFolder = 'Output/';

%% Create 'Output/' Folder if it does not exist
if (exist(outputFolder,'file') == 0)
    mkdir(outputFolder);
end


%% Save Images in the 'Output/' Folder 
fileNamePath = sprintf('%s%s%s.jpg',outputFolder, cell2mat(imageName),'_colorizing_without');
imwrite(imageWithoutCorr,fileNamePath);

fileNamePath = sprintf('%s%s%s_%s.jpg',outputFolder, cell2mat(imageName),'_colorizing_with', elapsedTimeSimple);
imwrite(imageWithCorr,fileNamePath);

fileNamePath = sprintf('%s%s%s_%s.jpg',outputFolder, cell2mat(imageName),'_colorizing_with_bonus', elapsedTimeFast);
imwrite(imageWithCorrBonus,fileNamePath);

end