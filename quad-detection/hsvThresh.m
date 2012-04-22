function vThresh = hsvThresh(inImage, val)

% Performs Value Tresholding on a given image relative to the average
% brightness.

% Convert the image to the HSV space
hsvImage = rgb2hsv(inImage);

% Get the value plane and threshold
vPlane = hsvImage(:,:,3);
valThresh = val * mean(mean(vPlane))^2;

% Find indeces that will be removed based on thresholding
vThresh = (vPlane < valThresh ) & (vPlane>0);

end