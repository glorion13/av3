function [ images ] = transformData( imgs )
%TRANSFORMDATA Summary of this function goes here
%   Detailed explanation goes here
[width, height, channels, nImages] = size(imgs);
images = zeros(height, width, channels, nImages);

for i=1: nImages
    im = normRGB(imgs(:,:,:,i));
    for j=1: channels
        images(:,:,j,i) = im(:,:,j)';
    end
end

