function I_aligned = FasterAlignWithNCCMetric( I_1 , I_2 , SearchSize)

%Function that tries to align the second image to the first by using the
%NCC Metric and the specified kernel size.
% Authors
%   * David Pfahler
% Input
%  I_1: The base image which I_2 gets aligned to
%  I_2: The image that gets aligned with I_1 must have the same size
%  SearchSize: The distance to seachrch for possible displacements of I_1 and I_2
% Output
%   I_aligned: The aligned I_2 image
% Example:
%   I_aligned = AlignWithNCCMetric( I_1 , I_2 , KernelSize)

% determining the maximum level of a pyramid by the maximum of the size
MaximumLevelByImageSize = ceil( log2( max( size( I_2 )) ) );

% The search size gets divided by 2 for every pyramid we have. So we only
% can have maximum logarithmus dualis of the search size image pyramids.
MaximumLevelBySearchSize = ceil(log2(SearchSize));

% Actually the search size should never be greater than the image size. But
% just for beeing sure...
NumPyramids = min(MaximumLevelByImageSize,MaximumLevelBySearchSize);

% The SearchSize gets set to 1 because of the above assumptions
SearchSize = 1;

% Create the pyramids cell array
c_Pyramids = cell(NumPyramids,2);
c_Pyramids(1,1) = {I_1};
c_Pyramids(1,2) = {I_2};

% Create pyramids for the Image 1 and 2 (-1 because the first image is
% already in the pyramid
for i = 1:NumPyramids-1
    c_Pyramids(i+1,1) = {impyramid(cell2mat(c_Pyramids(i,1)), 'reduce')};
    c_Pyramids(i+1,2) = {impyramid(cell2mat(c_Pyramids(i,2)), 'reduce')};
end

% This is the shift the I_2 image will get shifted after the calculation
FinShift = [0 0];

% Iterate from the smallest image to the biggest and on each iteration 
% get a better result for the final shift
for i = NumPyramids:-1:1
    
    % calculate the best match shift for the image pyramid for the base
    % image of the same image pyramid level and adjust this value with the
    % previous calculated shift time two because the shift comes from a
    % lower pyrimd level
    FinShift = AlignWithNCCMetric( ...
        cell2mat(c_Pyramids(i,1)), ...
        cell2mat(c_Pyramids(i,2)), ...
        SearchSize, ...
        FinShift * 2);
end

% Align the output Image with the sum of the multiplied shifts
I_aligned = circshift( I_2  , FinShift);

end