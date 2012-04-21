function [ finalImage ] = remap( inimage,image, plane, UV, DISTTOL )

    outimage = image(:,:,4:6);


    % get input image and sizes
    %inimage=imread('field.jpg','jpg');
    [IR,IC,D]=size(inimage);
    [OR,OC,D]=size(outimage);

    % An example of projective transfer

    XY=[[1,1]',[1,IC]',[IR,IC]',[IR,1]']';    % source points

    P=esthomog(UV,XY,4);    % estimate homography mapping UV to XY

    %outimage=zeros(250,180,3);   % destination image
    v=zeros(3,1);
    pnt = zeros(4,1);
    pnt(4) = 1;
    % loop over all pixels in the destination image, finding
    % corresponding pixel in source image
    for r = 1 : OR
        for c = 1 : OC
          v=P*[r,c,1]';        % project destination pixel into source
          y=round(v(1)/v(3));  % undo projective scaling and round to nearest integer
          x=round(v(2)/v(3));

          pnt(1:3) = image(r,c,1:3);

          if (x >= 1) && (x <= IC) && (y >= 1) && (y <= IR) && ...
                  (abs(pnt'*plane) < DISTTOL || pnt(3)==0 )
            outimage(r,c,:)=inimage(y,x,:)/255;   % transfer colour
          end
        end
    end

    finalImage(:,:,1:3) = image(:,:,1:3);
    finalImage(:,:,4:6) = outimage(:,:,1:3);
    
end

