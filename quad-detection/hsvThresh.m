function binarised = hsvThresh(inImage, val)

    % Convert the image to the HSV space
    hsvImage = rgb2hsv(inImage);
    
    % Get the hue plane
    hPlane = hsvImage(:,:,1);
    
    % Get the saturation plane
    sPlane = hsvImage(:,:,2);
    
    % Get the value plane
    vPlane = hsvImage(:,:,3);
    
    valThresh = val * mean(mean(vPlane))^2;     % relative to background brightness
    
    % Find indeces that will be removed based on thresholding
  %  hThresh = (hPlane<0.9 ) & (hPlane>0.8 );
  %  sThresh = (sPlane<sat ) & (sPlane>0);
    vThresh = (vPlane < valThresh ) & (vPlane>0);
    
    binarised = vThresh;
    
    indeces = find(binarised);
    
    % Set the selected pixel saturations to 0
    sPlane(indeces) = 0;

    % Update the saturation plane of the image
    hsvImage(:,:,2) = sPlane;
    
    % Convert the image back to RGB space
    outImage = hsv2rgb(hsvImage);
    %outImage = rgbToGray(outImage);
    
    % Remove selected pixels
    outImage(indeces) = 255;
    %outImage(~indeces) = 1;
    figure(1);
    imshow(hsvImage);
    figure(2);
    imshow(outImage);
    
end