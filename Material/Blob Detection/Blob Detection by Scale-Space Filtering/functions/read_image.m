%
% Reads in an image
% 
% inputs:  
% -------
% filename - path to the image file 
%
% outputs:  
% --------
% im - a 3D array
%
function im = read_image(filename, color_flag)

    if (nargin() ~= 2)
        color_flag = 0;
    end

    % Reads the desired file using the matlab function
    the_image = imread(filename);
    im_size = size(the_image);
    
    im = uint8(zeros(im_size(1), im_size(2), 3));    
    
    index = 1;
    
    % Get the extension
    for i=length(filename):-1:1
       
        if (filename(i) == '.')
            index = i+1;
            break;
        end
        
    end
    
    ext = filename(index:end);
    
    % These image types require special handling
    if (strcmp(ext, 'fts'))
        
       the_image = flipdim(the_image,1); 
       im(:,:,1) = the_image;
       im(:,:,2) = the_image;
       im(:,:,3) = the_image;
       return
       
    end
    
    if (color_flag)
        
        im = the_image;
        
    else
        
        if (length(size(the_image)) > 2)
            % Stores the image with only one color channel
            im = the_image(:,:,1);
        else
            % The image already has only 1 color channel
            im = the_image;
        end
    end
end