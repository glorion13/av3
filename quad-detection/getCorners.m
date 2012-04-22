function [ corners3d ] = getCorners( quadPts )
% This function gets the corners of a quad given a list of points. It finds
% the point which is further away from the centroid, and then removes all
% the points which are closer to that corner than to the centroid. Then it
% repeats this three more times.

corners3d = zeros(4,3);
nPts = length(quadPts);
centroid = mean(quadPts, 1);

dists3 = abs(quadPts - repmat(centroid, [nPts 1]));
dists = get3dLen( dists3 );


for i= 1: 4
    [~, idx] = max(dists);
    corners3d(i,:) = quadPts(idx, :);

    distsCor3 = abs(quadPts - repmat(corners3d(i,:), [length(quadPts) 1]));
    distsCor = get3dLen( distsCor3 );

    L = repmat(dists < distsCor, [1 3]);

    quadPts = quadPts( L );
    quadPts = reshape(quadPts,length(quadPts)/3, 3);

    dists3 = abs(quadPts - repmat(centroid, [length(quadPts) 1]));
    dists = get3dLen( dists3 );
end

end

