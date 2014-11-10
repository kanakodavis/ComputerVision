function [ scaleSpace ] = CreateScaleSpace( image, levels )
%Function that does the Color Image Segmentation by the K-means Clustering
% Authors
%   * Matthias Gusenbauer
% Input
%   image: The Image in to create the LOG scale space from
%   levels: defines the number of levels in the scale space
% Output
%   scaleSpace: A matrix(size: image.width * image.height * levels)
%   containing the scale space of the input image
%

factor = 1.25;
sigma = 2;
filterSize = 2 * floor(3 * sigma) + 1;
imSize = size(image);

scaleSpace = zeros(imSize(1), imSize(2), levels);

for i = 1:levels
    logFilter = fspecial('log', filterSize, sigma);
    logFilter = logFilter .* sigma^2;
    
    scaleSpace(:,:,i) = imfilter(image, logFilter, 'replicate');
    
    sigma = sigma * factor;
    filterSize = 2 * floor(3 * sigma) + 1;
end

end

