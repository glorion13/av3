function [ dists ] = get3dLen( dists3 )
% Finds the 3d length for all the points 

dists = dists3(:,1).^2 + dists3(:,2).^2 + dists3(:,3).^2;

end

