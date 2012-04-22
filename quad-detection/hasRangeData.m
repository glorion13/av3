function [ binary ] = hasRangeData( pts3d )
%HASRANGEDATA Summary of this function goes here
%   Detailed explanation goes here
ranges = pts3d(:,:,3);

binary = ranges ~= 0;

end

