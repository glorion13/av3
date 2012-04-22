function normImage = normRGB(image)
% gets the RGB values in the [0,1] range.

normImage(:,:,1:3) = image(:,:,1:3);
normImage(:,:,4:6) = image(:,:,4:6) / 255;
end