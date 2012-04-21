function [ image6d ] = fillMissingVals( image6d, bcg )
img = image6d(:,:,4:6);
    I =repmat(image6d(:,:,3)==0, [1 1 3]);    % distance (z-value) == 0
    
    img(I) = bcg(I) * mean(mean(mean(img))) / mean(mean(mean(bcg)));
    image6d(:,:,4:6) = img;

end

