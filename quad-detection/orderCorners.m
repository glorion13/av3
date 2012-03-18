function [ outputCorners ] = orderCorners( inputCorners )

    corners(:,1) = inputCorners(:,2);
    corners(:,2) = inputCorners(:,1);

    Cx = sum(corners(:,1)) / 4;
    Cy = sum(corners(:,2)) / 4;
    
    centre = [Cx, Cy];
    centre = repmat(centre, 4, 1);
    
    tmp = corners - centre;

    angles = atan2(tmp(:,1),tmp(:,2));
    [sortAngles, idx] = sort(angles,'descend');
    
    almostOrderedCorners = corners(idx,:);
    orderedCorners(1,:) = almostOrderedCorners(4,:);
    orderedCorners(2:4,:) = almostOrderedCorners(1:3,:);
    
    outputCorners(:,1) = orderedCorners(:,2);
    outputCorners(:,2) = orderedCorners(:,1);

end

