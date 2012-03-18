function outImage = rgbThresh(inImage)
    
    rgbImage = inImage;

    % Get the red plane
    rPlane = rgbImage(:,:,1);
    
    % Get the green plane
    gPlane = rgbImage(:,:,2);
    
    % Get the blue plane
    bPlane = rgbImage(:,:,3);
    
    % Find indeces that will be removed based on thresholding
    rThresh = (rPlane<0.176)&(rPlane>0.047);
    gThresh = (gPlane<0.09)&(gPlane>0.027);
    bThresh = (bPlane<0.15)&(bPlane>0.007);
    
    indeces = find((rThresh&gThresh&bThresh));
    
    outImage = rgbImage;
    
    % Remove selected pixels
    outImage(indeces) = 255;
    %outImage(~indeces) = 1;
    figure(1);
    imshow(outImage);
    
end