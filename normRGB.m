function normImage = normRGB(image)
    normImage(:,:,1:3) = image(:,:,1:3);
    normImage(:,:,4:6) = image(:,:,4:6) / 255;
end