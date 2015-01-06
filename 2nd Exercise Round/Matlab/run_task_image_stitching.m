function run_task_image_stitching()
%run_task_image_stitching Performing image stitching on given images

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
        [key, feat] = GetSIFTFeatures(Images{i}, true);
        SIFTDat{i, 1} = Images{i};
        SIFTDat{i, 2} = key;
        SIFTDat{i, 3} = feat;
    end
    
    for i=1:size(Images,2)
        %Part B
        tbd = IntPointMatching(SIFTDat(i, :), SIFTDat(mod((i+1),5), :));
    end
    
    %Do image processing
    
end

end

