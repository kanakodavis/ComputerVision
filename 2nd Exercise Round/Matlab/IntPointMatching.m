function [ transImage, homography ] = IntPointMatching( image1, image2 )
%IntPointMatching Summary of this function goes here
%   Perform interestpoint matching and registration on two consecutive
%   images

descriptor1 = image1{1, 3};
descriptor2 = image2{1, 3};

%Matches contains the indices of the original (first) AND closest
%descriptor in the other (second) image
[matches, scores] = vl_ubcmatch(descriptor1, descriptor2);

matchedDesc1 = descriptor1(:,matches(1,:));
matchedDesc2 = descriptor2(:,matches(2,:));

points1 = image1{1, 2};
points1 = points1(1:2,matches(1,:))';

points2 = image2{1, 2};
points2 = points2(1:2,matches(2,:))';

%Plot matches
match_plot(im2double(image1{1,1}), im2double(image2{1,1}), points1, points2);

%Do RANSAC
homography = PerfRANSAC(points1, points2, image1, image2);

%5 Transform image
transImage = imtransform(image1{1,1}, homography);
imshow(transImage);
%transImage = imtransform(image1{1,1}, homography, 'XData', [1 size(image1{1,1}, 2)], 'YData', [1 size(image1{1,1}, 1)], 'XYScale', 1);


%NOTES
%TODO retrieve points from image via matches and then feed to
%match_plot(image1, image2, points1, points2);
%probably each column in descriptor == 1 descriptor -> index from matches
%== column index
%point probably in image1{1, 2} (each column of image1{1, 2} corresponds to one in image{1, 3})
%according to website: A frame is a disk of center f(1:2), scale f(3) and orientation f(4)
%so 1:2 from a frame from image1{1, 2} should be the points
    
    %Part B
    %%1) take two consecutive images
    %%transform both with rgb2gray
    %%get siftfeatures for both
    %%2) match descriptors with vl_ubcmatch and plot with match_plot
    %%3) perform RANSAC - own function N = 1000 times NOTE: save homograph.
    %%with max inliers for step 4.
    %%%a) chose 4 random matches
    %%%b) estimate homography with cp2tform with 'projective' as parameter -
    %%%try catch(outliers)
    %%%c) transform all other points of match in first image using tformfwd
    %%%d) determine inliers: compute euclidean dist of transformed points of
    %%%first image and corresp. points in second image and count match as
    %%%inlier if < threshold
    %%4) after N runs take homography with max nr of inliers -> reestimate
    %%homography with all inliers
    %%5) transform first image onto second image with imtransform and Xdata
    %%and Ydata as well as XYscale as parameters for correct scaling

end

