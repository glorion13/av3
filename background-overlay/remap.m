function [ outimage ] = remap( inimage,outimage )

% get input image and sizes
%inimage=imread('field.jpg','jpg');
[IR,IC,D]=size(inimage);
[OR,OC,D]=size(outimage);

% An example of projective transfer

UV=zeros(4,2);
XY=zeros(4,2);
UV=[[130,41],[429,39],[90,474],[452,473]]';    % target points
XY=[[1,1]',[1,IR]',[IC,IR]',[IC,1]']';    % source points

P=esthomog(UV,XY,4);    % estimate homography mapping UV to XY

%IC = 250
%IR = 180

%outimage=zeros(250,180,3);   % destination image
v=zeros(3,1);

% loop over all pixels in the destination image, finding
% corresponding pixel in source image
for r = 1 : OC
for c = 1 : OR
  v=P*[r,c,1]';        % project destination pixel into source
  y=round(v(1)/v(3));  % undo projective scaling and round to nearest integer
  x=round(v(2)/v(3));
  if (x >= 1) && (x <= IC) && (y >= 1) && (y <= IR)
    outimage(r,c,:)=inimage(y,x,:)/255;   % transfer colour
  end
end
end

figure(1)
imshow(outimage)
