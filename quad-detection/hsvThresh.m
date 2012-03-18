function outImage = hsvThresh(inImage)

    % Convert the image to the HSV space
    hsvImage = rgb2hsv(inImage);
    
    % Get the hue plane
    hPlane = hsvImage(:,:,1);
    
    % Get the saturation plane
    sPlane = hsvImage(:,:,2);
    
    % Get the value plane
    vPlane = hsvImage(:,:,3);
    
    % Find indeces that will be removed based on thresholding
    hThresh = (hPlane<0.9)&(hPlane>0.8);
    sThresh = (sPlane<0.6)&(sPlane>0.48);
    vThresh = (vPlane<0.12)&(vPlane>0.08);
    
    indeces = find(hThresh&sThresh&vThresh)
    
    % Set the selected pixel saturations to 0
    sPlane(indeces) = 0;

    % Update the saturation plane of the image
    hsvImage(:,:,2) = sPlane;
    
    % Convert the image back to RGB space
    outImage = hsv2rgb(hsvImage);
    outImage = rgbToGray(outImage);
    
    % Remove selected pixels
    outImage(indeces) = 0;
    %outImage(~indeces) = 1;
    figure(1);
    imshow(mat2gray(outImage));
    
end