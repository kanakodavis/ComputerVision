function [ scaleSpace ] = CreateScaleSpace( image, sigmas )
%Function that creates the scale space for the scale invariant blob
%detection
% Authors
%   * Matthias Gusenbauer
% Input
%   image: The Image in to create the LOG scale space from
%   sigmas: the precalculated sigmas for the LOG kernel
% Output
%   scaleSpace: A matrix(size: image.width * image.height * levels)
%   containing the scale space of the input image
%
image = double(image);
[levels, ~] = size(sigmas);
imSize = size(image);

scaleSpace = zeros(imSize(1), imSize(2), levels);

for i = 1:levels
    sigma = sigmas(i);
    filterSize = 2 * floor(3 * sigma) + 1;
    logFilter = fspecial('log', filterSize, sigma);
    logFilter = logFilter .* sigma^2;
    
    scaleSpace(:,:,i) = imfilter(image, logFilter, 'replicate');
end

scaleSpace = abs(scaleSpace);

end

