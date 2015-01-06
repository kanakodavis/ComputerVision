function [ tbd ] = IntPointMatching( image1, image2 )
%IntPointMatching Summary of this function goes here
%   Perform interestpoint matching and registration on two consecutive
%   images


    
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

