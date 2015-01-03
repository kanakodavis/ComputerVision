function [ key, desc ] = GetSIFTFeatures( image, doPlot )
%GetSIFTFeatures extracts and plots the SIFT features of the given image.
% also returns the features of the image
% image the image to extract features from
% doPlot boolean for feature plotting

if(nargin == 1)
    doPlot = false;
end

siftIm = single(rgb2gray(image));

[key, desc] = vl_sift(siftIm);

 if(doPlot)
     figure;
     hold on;
     imshow(image); %chose siftIm for grayscale image
     h1 = vl_plotframe(key);
     set(h1, 'color', 'y', 'linewidth', 1);
     hold off;
 end

end

