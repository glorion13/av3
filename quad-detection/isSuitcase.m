function [ isSuitcase ] = isSuitcase( pts3d )
%SUITCASECHECK Summary of this function goes here
%   Detailed explanation goes here
    isSuitcase = length(pts3d) > 5000;

end

