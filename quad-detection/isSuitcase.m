function [ isSuitcase ] = isSuitcase( pts3d )
    % This function simply checks if a set of points in 3D space is large
    % enough to be assumed to be the correct quad (suitcase of the man).
    
    nPoints = length(pts3d);
    nPointsTest = nPoints > 10000;
    % residual error of the plane is already checked

    isSuitcase = nPointsTest;
    
end

