function [ points3d ] = getRange( img, points )
%GETRANGE Summary of this function goes here
%   Detailed explanation goes here

[nPoints, nDims] = size(points);
points3d = zeros(nPoints,nDims+1);
for i=1:nPoints
    points3d(i,:) = img(points(i,1), points(i,2), 1:3);


end

