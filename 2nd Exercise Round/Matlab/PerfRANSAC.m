function [ homography ] = PerfRANSAC( points1, points2 )
%PerfRANSAC Performs RANSAC N times in order to find matching points and
%correct homography
%   Detailed explanation goes here

N = 1000;

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
end

