function [ homography ] = PerfRANSAC( points1, points2 ,image1, image2)
%PerfRANSAC Performs RANSAC N times in order to find matching points and
%correct homography
%   Detailed explanation goes here

N = 1000;
bestInliersCnt = 0;
bestInliers = 0; %not necessary
bestHomo = 0;


for(i=1:N)
    %a) get 4 random points
    randoms = randsample(size(points1, 1),4);
    
    rndPnts1 = points1(randoms,:);
    rndPnts2 = points2(randoms,:);
    
    %match_plot(im2double(image1{1,1}), im2double(image2{1,1}), rndPnts1, rndPnts2);
        
    try
        %b) - d)
        [nrInliers, inliers, TFORM] = tformAInliers(points1, points2, rndPnts1, rndPnts2);
        
        %if new calculation is better than old update result
        if(nrInliers > bestInliersCnt)
            disp(sprintf('Best match - #of inliers %d', nrInliers));
            bestInliersCnt = nrInliers;
            bestInliers = inliers; %not necessary
            bestHomo = TFORM;
        end
        
    catch err
        %ERROR if malformed samples - ignore
        disp('Ouch!');
    end
end

%4) after N runs take best homography and reestimate with all points
points1 = tformfwd(bestHomo, points1(:,1), points1(:,2));
%points2 = tformfwd(bestHomo, points2(:,1), points2(:,2));
[~, ~, homography] = tformAInliers(points1, points2, points1, points2);

end

function [ nrInliers, inliers, homography ] = tformAInliers( points1, points2, rndPnts1, rndPnts2)

T = 5;

%b) estimate transformation ob rndPnts1 onto rndPnts2
homography = cp2tform(rndPnts1, rndPnts2, 'projective');

%c) transform the points 
trnsfrmdPnts = tformfwd(homography, points1(:,1), points1(:,2));

%d) calc euclidean distance
distance = (trnsfrmdPnts - points2).^2; %one line sqrt(sum(.))
distance = sqrt(distance(:, 1) + distance(:, 2));

%do thresholding
inliers = distance<=T;
nrInliers = sum(inliers);

end