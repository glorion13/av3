function indeces = handRemoval(inImage)
    
    rgbImage = inImage;

    % Get the red plane
    rPlane = rgbImage(:,:,1);
    
    % Get the green plane
    gPlane = rgbImage(:,:,2);
    
    % Get the blue plane
    bPlane = rgbImage(:,:,3);
    
    % Find indeces that will be returned based on thresholding
    rThresh = (rPlane<0.19)&(rPlane>0);
    gThresh = (gPlane<0.25)&(gPlane>0);
    bThresh = (bPlane<0.15)&(bPlane>0);
    
    indeces = (rThresh&gThresh&bThresh);
    
    rgbImage(indeces) = 255;
    
    figure(1);
    imshow(rgbImage);
    
end