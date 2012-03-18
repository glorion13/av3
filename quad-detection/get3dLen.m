function [ dists ] = get3dLen( dists3 )
%GET3DLEN Summary of this function goes here
%   Detailed explanation goes here
dists = dists3(:,1).^2 + dists3(:,2).^2 + dists3(:,3).^2;

end

