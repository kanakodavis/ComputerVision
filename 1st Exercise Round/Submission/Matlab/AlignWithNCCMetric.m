function [BestMatchCircShift, BestMatchMetric] = AlignWithNCCMetric( I_1 , I_2 , SearchSize, SearchOffset)

%Function that tries to align the second image to the first by using the
%NCC Metric and the specified kernel size.
% Authors
%   * David Pfahler
% Input
%  I_1: The base image which I_2 gets aligned to
%  I_2: The image that gets aligned with I_1
%  SearchSize: The distance to seachrch for possible displacements of I_1 and I_2
%  SearchOffset: The offset where the search should get started from each
%  pixel. Default = [0 0]
% Output
%   BestMatchCircShift: The shift that the image I_2 has to get to get
%   aligned to I_1
%   BestMatchMetric: The Value of the metric the higher the better. 
% Example:
%   BestMatchCircShift = AlignWithNCCMetric( I_1 , I_2 , KernelSize)
%   BestMatchCircShift = AlignWithNCCMetric( I_1 , I_2 , KernelSize, [offsetX offsetY])
%   I_aligned = circshift( I_2 , BestMatchCircShift );

if nargin < 4
    SearchOffset = [0 0];
end
BestMatchMetric = 0;
BestMatchCircShift = SearchOffset;

% Only search the center 70% of the image to reduce the error from the
% borders
CutLeftUpper = floor(size(I_1) .* 0.15);
CutRightBottom = ceil(size(I_1) .* 0.85);
x = CutLeftUpper(1):CutRightBottom(1);
y = CutLeftUpper(2):CutRightBottom(2);
I_1 = I_1(x,y,:);
I_2 = I_2(x,y,:);

% Filter the image with the laplacian of the gaussion before calculating
% the metric to get better features
 h = fspecial('log');
 I_FILTERED_1 = imfilter(I_1,h);
 I_FILTERED_2 = imfilter(I_2,h);

for i = SearchOffset(1)-SearchSize:SearchOffset(1)+SearchSize
   for j = SearchOffset(2)-SearchSize:SearchOffset(2)+SearchSize 
       I_2_Shifted = circshift(I_2,[i j]);
       I_FILTERED_2_Shifted = circshift(I_FILTERED_2,[i j]);
       % metric that calculates how good the image is aligned
       MatchMetric = corr2(I_1,I_2_Shifted) + corr2(I_FILTERED_1,I_FILTERED_2_Shifted);
%       MatchMetric = corr2(I_1,I_2_Shifted);
       % update best match if it is better
       if MatchMetric > BestMatchMetric
           BestMatchMetric = MatchMetric;
           BestMatchCircShift = [i j];
       end
   end
end
end