function [ ] = writeImgs( images, range, fname )
%writes the images

for i=range
    imwrite(images(:,:,4:6,i), ['output/',int2str(i),fname,'.jpg'] );
end


end

