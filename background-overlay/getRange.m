function [ points3d ] = getRange( img, points )
% Given a list of pixel indeces returns a corresponding list of 3d points.

[nPoints, nDims] = size(points);
points3d = zeros(nPoints,nDims+1);

for i=1:nPoints
    points3d(i,:) = img(points(i,1), points(i,2), 1:3);
end

end

