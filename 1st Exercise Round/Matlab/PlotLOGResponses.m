function PlotLOGResponses( scales, smallResp, bigResp )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

figure
stem(scales, smallResp, 'filled');
stem(scales, bigResp, 'r', 'filled');
xlim([1.5 max(scales)+0.5]);

end

