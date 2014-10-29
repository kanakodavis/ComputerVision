function I_aligned = AlignWithNCCMetric( I_1 , I_2 , SearchSize)

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

% Metric = corr2(KernelPartA,KernelPartB)

BestMatchMetric = 0;
BestMatchCircShift = [0 0];

for i = -SearchSize:SearchSize
   for j = -SearchSize:SearchSize 
       I_2_Shifted = circshift(I_2,[i j]);
       MatchMetric = corr2(I_1,I_2_Shifted);
       if MatchMetric > BestMatchMetric
           BestMatchMetric = MatchMetric;
           BestMatchCircShift = [i j];
       end
   end
end

I_aligned = circshift(I_2,BestMatchCircShift);
end