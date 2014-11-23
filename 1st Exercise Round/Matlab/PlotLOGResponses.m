function PlotLOGResponses( scales, smallResp, bigResp )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

figure
hold on
stem(scales, smallResp, 'filled');
stem(scales, bigResp, 'r', 'filled');
legend('Image orig. size','Image half size','Location','northwest')
xlim([1.5 max(scales)+0.5]);
xlabel('LoG size');
ylabel('LoG response');
hold off

end

