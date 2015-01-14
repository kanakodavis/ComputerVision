function run_task_image_stitching()
%run_task_image_stitching Performing image stitching on given images

%Check if VL toolbox is installed and install if not
if (~exist('vl_version'))
    run('vlfeat/toolbox/vl_setup');
end

addpath('Material');

ImageNames = {'Material/campus','Material/officeview'};
ImageFileType = '.jpg';

for imageName = ImageNames
    
    %Create image names and load images
    ImNames = cell(5, 1);
    Images = cell(1, 5);
    for i=1:5
        ImNames(i) = strcat(strcat(imageName, num2str(i)), ImageFileType);
        Images{i} = imread(ImNames{i});
    end
    
    %Part A
    SIFTDat = cell(5, 3);
    for i=1:size(Images,2)
        [key, feat] = GetSIFTFeatures(Images{i}, false);
        SIFTDat{i, 1} = Images{i};
        SIFTDat{i, 2} = key;
        SIFTDat{i, 3} = feat;
    end
    
    % C1 - Determine the homographies between all image pairs from left to
    % right. e.g. imagePairs{1,2} represents Homography H(1-2)
    imagePairs = cell(4,2);
    for i = 1:(size(Images,2)-1)
        [tImage, homography] = IntPointMatching(SIFTDat(i, :), SIFTDat(i+1, :));
        imagePairs{i,1} = tImage;
        imagePairs{i,2} = homography;
    end
    
    %for i=1:size(Images,2)
        %Part B
    %    [tImage, homography] = IntPointMatching(SIFTDat(i, :), SIFTDat(mod((i+1),5), :));
    %end
    
    %Do image processing
    
end

end

