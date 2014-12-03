function PlotLOGResponses( scales, smallResp, bigResp )
% PlotLOGResponses is a simple function that creates a stem plot of two
% different data sets.
% Authors
%   * Matthias Gusenbauer
% Input
%   scales: The sigmas used for scale space calculation
%   smallResp: Responses of the half sized image for the given sigmas
%   bigResp: Responses of the full sized image for the given sigmas
% Output
%   window with plot

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

