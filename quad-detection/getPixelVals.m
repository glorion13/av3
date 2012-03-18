function [ corners ] = getPixelVals( corners3d, image )
%GETPIXELVALS Summary of this function goes here
%   Detailed explanation goes here

corners = zeros(4,2);

for i = 1: 4
    [x y] = find(image==corners3d(i,:));
    corners(i,:) = [x y];

end

