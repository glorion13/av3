function [ images ] = transformData( imgs )
% Normalises the images (so that RGB is in double as well) and transposes
% the data.

[width, height, channels, nImages] = size(imgs);
images = zeros(height, width, channels, nImages);

for i=1: nImages

    im = normRGB(imgs(:,:,:,i));
    for j=1: channels
        images(:,:,j,i) = im(:,:,j)';
    end

end
    
end

