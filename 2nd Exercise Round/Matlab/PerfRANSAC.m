function [ homography ] = PerfRANSAC( points1, points2 )
%PerfRANSAC Performs RANSAC N times in order to find matching points and
%correct homography
%   Detailed explanation goes here

N = 1000;
bestInliers = 0;
bestHomo = 0;


for(i=1:N)
    %a) get 4 random points
    randoms = randsample(size(points1, 1),4);
    
    rndPnts1 = points1(randoms,:);
    rndPnts2 = points2(randoms,:);
    
    try
        %b) - d)
        [nrInliers TFORM] = tformAInliers(points1, points2, rndPnts1, rndPnts2);
        
        %if new calculation is better than old update result
        if(nrInliers > bestInliers)
            bestInliers = nrInliers;
            bestHomo = TFORM;
        end
        
    catch err
        %ERROR if malformed samples - ignore
        disp('Ouch!');
    end
end

%4) after N runs take best homography and reestimate with all points
[blup TFORM] = tformAInliers(points1, points2, points1, points2);

homography = TFORM;

end

function [ inliers homography ] = tformAInliers( points1, points2, rndPnts1, rndPnts2)

T = 5;

%b) estimate transformation ob rndPnts1 onto rndPnts2
homography = cp2tform(rndPnts2, rndPnts1, 'projective');

%c) transform the points 
trnsfrmdPnts = tformfwd(homography, points1(:,1), points1(:,2));

%d) calc euclidean distance
distance = (trnsfrmdPnts - points2).^2;
distance = sqrt(distance(:, 1) + distance(:, 2));

%do thresholding
inliers = sum(distance<T);

end