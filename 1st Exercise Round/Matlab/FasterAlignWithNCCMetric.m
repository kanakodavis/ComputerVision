function I_aligned = FasterAlignWithNCCMetric( I_1 , I_2 , SearchSize)

%Function that tries to align the second image to the first by using the
%NCC Metric and the specified kernel size.
% Authors
%   * David Pfahler
% Input
%  I_1: The base image which I_2 gets aligned to
%  I_2: The image that gets aligned with I_1
%  SearchSize: The distance to seachrch for possible displacements of I_1 and I_2
% Output
%   I_aligned: The aligned I_2 image
% Example:
%   I_aligned = AlignWithNCCMetric( I_1 , I_2 , KernelSize)

% Number of pyramids is that high that the smallest pyramid aproximatly
% 100px high
NumPyramids = floor(max(size(I_2))/100);

% The SearchSize gets devided by the number of pyramids to ensure the
% advantage of this method (its faster to align with a smaller search size
% kernel)
SearchSize = SearchSize / NumPyramids;

% Filter the image with the laplacian of the gaussion before calculating
% the metric to get better features
h = fspecial('log');
I_LOG_1 = imfilter(I_1,h);
I_LOG_2 = imfilter(I_2,h);

% Create the pyramids cell array
c_Pyramids = cell(NumPyramids+1,2);
c_Pyramids(1,1) = {I_LOG_1};
c_Pyramids(1,2) = {I_LOG_2};

% Create pyramids for the LOG of Image 1 and 2
for i = 1:NumPyramids
    c_Pyramids(i+1,1) = {impyramid(cell2mat(c_Pyramids(i,1)), 'reduce')};
    c_Pyramids(i+1,2) = {impyramid(cell2mat(c_Pyramids(i,2)), 'reduce')};
end

for i = NumPyramids+1:-1:1
    BestMatchCircShift = AlignWithNCCMetric(cell2mat(c_Pyramids(i,1)),cell2mat(c_Pyramids(i,2)),SearchSize);
    for j = i-1:-1:1
        BestMatchCircShift = BestMatchCircShift * 2;
        c_Pyramids(j,2)  = {circshift( cell2mat(c_Pyramids(j,2))  , BestMatchCircShift)};
    end
    I_2 = circshift( I_2  , BestMatchCircShift);
end

I_aligned = I_2;

end