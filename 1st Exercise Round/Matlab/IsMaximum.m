function [ maximum ] = IsMaximum( scalespace, x, y, z )
%Function checks for local maxima in an 8 and 9 neighbourhood around x, y,
%z and returns true if it is a maximum
% Authors
%   * Matthias Gusenbauer
% Input
%   scalespace: The Image in to create the LOG scale space from
%   x: x-coordinate to check maximum in scale space
%   y: y-coordinate to check maximum in scale space
%   z: z-coordinate to check maximum in scale space
% Output
%   maximum: a boolean for true if is maximum and false if not
%

maximum = false;

[x_max, y_max, z_max] = size(scalespace);

%Get neighbour coordinates - with bounds check
x_minus = max(1, x - 1);
x_plus = min(x_max, x + 1);

y_minus = max(1, y - 1);
y_plus = min(y_max, y + 1);

z_minus = max(1, z - 1);
z_plus = min(z_max, z + 1);

%Get actual value
pos = scalespace(x, y, z);

if(...
    (pos > scalespace(x_minus, y_minus, z_minus) && pos > scalespace(x_minus, y, z_minus) && scalespace(x_minus, y_plus, z_minus)) ...%first row of sigma_i-1
    && (pos > scalespace(x, y_minus, z_minus) && pos > scalespace(x, y, z_minus) && scalespace(x, y_plus, z_minus)) ...%second row of sigma_i-1
    && (pos > scalespace(x_plus, y_minus, z_minus) && pos > scalespace(x_plus, y, z_minus) && scalespace(x_plus, y_plus, z_minus)) ...%third row of sigma_i-1
    && (pos > scalespace(x_minus, y_minus, z) && pos > scalespace(x_minus, y, z) && scalespace(x_minus, y_plus, z)) ...%first row of sigma
    && (pos > scalespace(x, y_minus, z) && scalespace(x, y_plus, z)) ...%second row of sigma
    && (pos > scalespace(x_plus, y_minus, z) && pos > scalespace(x_plus, y, z) && scalespace(x_plus, y_plus, z)) ...%third row of sigma
    && (pos > scalespace(x_minus, y_minus, z_plus) && pos > scalespace(x_minus, y, z_plus) && scalespace(x_minus, y_plus, z_plus)) ...%first row of sigma_i+1
    && (pos > scalespace(x, y_minus, z_plus) && pos > scalespace(x, y, z_plus) && scalespace(x, y_plus, z_plus)) ...%second row of sigma_i+1
    && (pos > scalespace(x_plus, y_minus, z_plus) && pos > scalespace(x_plus, y, z_plus) && scalespace(x_plus, y_plus, z_plus)) ...%third row of sigma_i+1
    )
    maximum = true;
end

end

