function run_task_image_stitching()
%run_task_image_stitching Performing image stitching on given images

%Check if VL toolbox is installed and install if not
if (~exist('vl_version'))
    run('vlfeat/toolbox/vl_setup');
end

close all;

addpath('Material');

ImageNames = {'Material/campus','Material/officeview'};
ImageFileType = '.jpg';

ImageNamesOwn = {'Material/stitching/soldier','Material/stitching/charlie'};
ImageFileType = '.jpg';

ImageNamesRotation = {'Material/rotation/campus','Material/rotation/officeview'};
ImageFileType = '.jpg';

doRS = false;
doPlot = true; % TODO for Report see images = true

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
    rsSIFTDat = cell(5, 3);
    for i=1:size(Images,2)
        [key, feat] = GetSIFTFeatures(Images{i}, doPlot);
        SIFTDat{i, 1} = Images{i};
        SIFTDat{i, 2} = key;
        SIFTDat{i, 3} = feat;
        
        if(doRS)
            rsSIFTDat{i, 1} = imrotate(imresize(Images{i}, .8), 180);
            [rskey, rsfeat] = GetSIFTFeatures(rsSIFTDat{i, 1}, doPlot);
            rsSIFTDat{i, 2} = rskey;
            rsSIFTDat{i, 3} = rsfeat;
        end
    end
    
    %% C1 - Determine the homographies between all image pairs from left to
    % right. e.g. imagePairs{1,2} represents Homography H(1-2)
    imageTransformation = cell(4,4);
    
    if(doRS)
    % H(1-2)
        H_1_2 = IntPointMatching(SIFTDat(1, :), rsSIFTDat(2, :), doPlot);
        % H(2-3)
        H_2_3 = IntPointMatching(SIFTDat(2, :), rsSIFTDat(3, :), doPlot);
        % H(4-3)
        H_4_3 = IntPointMatching(SIFTDat(4, :), rsSIFTDat(3, :), doPlot);
        % H(5-4)
        H_5_4 = IntPointMatching(SIFTDat(5, :), rsSIFTDat(4, :), doPlot);
    else
        % H(1-2)
        H_1_2 = IntPointMatching(SIFTDat(1, :), SIFTDat(2, :), doPlot);
        % H(2-3)
        H_2_3 = IntPointMatching(SIFTDat(2, :), SIFTDat(3, :), doPlot);
        % H(4-3)
        H_4_3 = IntPointMatching(SIFTDat(4, :), SIFTDat(3, :), doPlot);
        % H(5-4)
        H_5_4 = IntPointMatching(SIFTDat(5, :), SIFTDat(4, :), doPlot);
    end
        
    % if needed
    H_3_3 = maketform('affine',[1 0 0 ; 0 1 0; 0 0 1]);
    
    
    %% Choose a reference image - create composite homographies to map an 
    % image over a sequence of consecutive images to the reference image
    
    %   H_1_3            H(2-3)                  H(1-2)
    H_1_3 = H_1_2;
    H_1_3.tdata.T    = H_2_3.tdata.T    * H_1_2.tdata.T;
    H_1_3.tdata.Tinv = H_2_3.tdata.Tinv * H_1_2.tdata.Tinv;
    
    %   H_5_3            H(4-3)                  H(5-4)
    H_5_3 = H_5_4;
    H_5_3.tdata.T    = H_4_3.tdata.T    * H_5_4.tdata.T;
    H_5_3.tdata.Tinv = H_4_3.tdata.Tinv * H_5_4.tdata.Tinv;
    
        
    %% Compute Size of the output panorama
    xLim = zeros(4,2);
    yLim = zeros(4,2);
    
    [transImage, xLim(1,:), yLim(1,:)] = imtransform(Images{1}, H_1_3);
    %figure, imshow(transImage);
    [transImage, xLim(2,:), yLim(2,:)] = imtransform(Images{2}, H_2_3);
    %figure, imshow(transImage);
    [transImage, xLim(3,:), yLim(3,:)] = imtransform(Images{4}, H_4_3);
    %figure, imshow(transImage);
    [transImage, xLim(4,:), yLim(4,:)] = imtransform(Images{5}, H_5_3);
    %figure, imshow(transImage);
    
    xMin = floor(min(min(xLim)));
    xMax = ceil(max(max(xLim)));
    
    yMin = floor(min(min(yLim)));
    yMax = ceil(max(max(yLim)));
    
    % Width and height of panorama.
    width  = round(xMax - xMin);
    height = round(yMax - yMin);
    
    
    %% Transform all images to the plane defined by the reference image
    TransfImages = cell(1, 5);
    
    [TransfImages{1}] = imtransform(Images{1}, H_1_3, 'XData', [xMin xMax], 'YData', [yMin yMax]);
    %figure, imshow(TransfImages{1});

    [TransfImages{2}] = imtransform(Images{2}, H_2_3, 'XData', [xMin xMax], 'YData', [yMin yMax]);
    %figure, imshow(TransfImages{2});

    [TransfImages{3}] = imtransform(Images{3}, H_3_3, 'XData', [xMin xMax], 'YData', [yMin yMax]);
    %figure, imshow(TransfImages{3});

    [TransfImages{4}] = imtransform(Images{4}, H_4_3, 'XData', [xMin xMax], 'YData', [yMin yMax]);
    %figure, imshow(TransfImages{4});

    [TransfImages{5}] = imtransform(Images{5}, H_5_3, 'XData', [xMin xMax], 'YData', [yMin yMax]);
    %figure, imshow(TransfImages{5});
    
    if(false)
        diff = imabsdiff(TransfImages{1}, TransfImages{2});
        diff = imabsdiff(diff, TransfImages{3});
        diff = imabsdiff(diff, TransfImages{4});
        diff = imabsdiff(diff, TransfImages{5});
        figure; imshow(diff);
        title('Absolute image differences.');
    end

    %% 5. Blend overlapping color values in a way to avoid seams. Method called feathering
    interpolationF = cell(1, 5);
    
    bw = zeros(size(Images{i})); 
    s  = size(bw);
    % Setting 4 Corners:
    bw(1,:)    = 1; 
    bw(:,1)    = 1; 
    bw(:,s(2)) = 1; 
    bw(s(1),:) = 1; 
    % Setting Interpolation between 0 and 1
    interpImage = mat2gray(bwdist(bw,'euclidean'));
    
    % Transforming the interpolation as well with homographies
    interpolationF{1} = imtransform(interpImage, H_1_3, 'XData', [xMin xMax], 'YData', [yMin yMax]);
    %figure, imshow(interpolationF{1});
    interpolationF{2} = imtransform(interpImage, H_2_3, 'XData', [xMin xMax], 'YData', [yMin yMax]);
    %figure, imshow(interpolationF{2});
    interpolationF{3} = imtransform(interpImage, H_3_3, 'XData', [xMin xMax], 'YData', [yMin yMax]);
    %figure, imshow(interpolationF{3});
    interpolationF{4} = imtransform(interpImage, H_4_3, 'XData', [xMin xMax], 'YData', [yMin yMax]);
    %figure, imshow(interpolationF{4});
    interpolationF{5} = imtransform(interpImage, H_5_3, 'XData', [xMin xMax], 'YData', [yMin yMax]);
    %figure, imshow(interpolationF{5});
    
    % feathering Formel
    zaehler = zeros(size(TransfImages{1}));
    nenner  = zeros(size(TransfImages{1}));       
    for i=1:5
        zaehler  = zaehler + ((im2double(TransfImages{i})>0)==1) .* interpolationF{i};
        nenner   = nenner  + im2double(TransfImages{i})          .* interpolationF{i};
    end
    
    % Create Panorama Picture
    panorama = nenner ./ zaehler;
    
    figure, imshow(panorama), title('With blending');
    
    
    %% Without blending ---- delete me -----
%     f = zeros(size(TransfImages{1}));
%     
%     for k = 1:5
%         image = im2double(TransfImages{k});
%                  
%         for i=1:size(TransfImages{1},1)
%             for j=1:size(TransfImages{1},2)
% 
%                     if (image(i,j,1) == 0 & image(i,j,2) == 0 & image(i,j,3) == 0)
%                         continue;
%                     else
%                         f(i,j,:) = image(i,j,:);
%                     end
% 
%             end
%         end
%     end
%     figure, imshow(f), title('Without blending');
%     % ---- delete me end -
    
end

end

