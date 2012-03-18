function [ corners ] = getCorners( quadPts )
%GETCORNERS Summary of this function goes here
%   Detailed explanation goes here
corners = zeros(4,2);
nPts = length(quadPts);

centroid = mean(quadPts, 1);

dists = abs(quadPts - repmat(centroid, [nPts 1]));


centroid
quadPts(1:10,:)
dists(1:10,:)




end

