function [ sigma ] = InitSigma( levels )
%Function that initializes the sigmas for the LOG
% Authors
%   * Matthias Gusenbauer
% Input
%   levels: defines the number of sigmas to be used for LOG
% Output
%   sigma: A vector of sigmas to be used for scale space creation
%

factor = 1.25; %Factor to be multiplied to sigma each time
firstSig = 2; %Sigma_0 for LOG
sigma = zeros(levels, 1);

for i=1:levels
    sigma(i) = firstSig;
    firstSig = firstSig * factor;
end

end

