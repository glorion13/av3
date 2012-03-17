function normImage = normRGB(image)
    image(:,:,4:6) / 255;
    normImage = image;
end