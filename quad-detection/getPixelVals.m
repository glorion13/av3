function [ corners ] = getPixelVals( corners3d, image )

    [r1,c1] = find((image(:,:,1) == corners3d(1,1)) & (image(:,:,2) == corners3d(1,2)) & (image(:,:,3) == corners3d(1,3)));
    [r2,c2] = find((image(:,:,1) == corners3d(2,1)) & (image(:,:,2) == corners3d(2,2)) & (image(:,:,3) == corners3d(2,3)));
    [r3,c3] = find((image(:,:,1) == corners3d(3,1)) & (image(:,:,2) == corners3d(3,2)) & (image(:,:,3) == corners3d(3,3)));
    [r4,c4] = find((image(:,:,1) == corners3d(4,1)) & (image(:,:,2) == corners3d(4,2)) & (image(:,:,3) == corners3d(4,3)));
    
    corners(1,1:2) = [r1,c1];
    corners(2,1:2) = [r2,c2];
    corners(3,1:2) = [r3,c3];
    corners(4,1:2) = [r4,c4];

end
