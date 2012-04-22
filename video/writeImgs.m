function [ ] = writeImgs( images, range, fname )
%Writes the images in the output folder

for i=range
    imwrite(images(:,:,4:6,i), ['output/',int2str(i),fname,'.jpg'] );
end


end

