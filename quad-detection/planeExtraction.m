function [ oldlist ] = planeExtraction( image )


im3d = image(:,:,1:3);
imRGB= image(:,:,4:6);

binary = rgbThresh(imRGB);
excludingNonBag = handRemoval(imRGB);

initialPts = im3d(repmat(binary,[1 1 3]));
inclusiveBagPts = im3d(repmat(excludingNonBag,[1 1 3]));

R = reshape(im3d, 640*480,3); % 3d points
initialPts = reshape(initialPts, length(initialPts)/3,3);
inclusiveBagPts = reshape(inclusiveBagPts, length(inclusiveBagPts)/3,3);

figure(1)
clf
hold on
plot3(initialPts(:,1),initialPts(:,2),initialPts(:,3),'k.')
pause(5)

[NPts,W] = size(R);
plane = zeros(20);

% find surface patches
% here just get 5 first planes - a more intelligent process should be
% used in practice. Here we hope the 4 largest will be included in the
% 5 by virtue of their size
remaining = inclusiveBagPts; 

% select a random small surface patch
[oldlist,plane] = select_patch(initialPts);

% grow patch
stillgrowing = 1;

while stillgrowing

  DISTTOL  = 0.01;
  PLANETOL = 0.05;   %don't check distance to the closest point
% find neighbouring points that lie in plane
  stillgrowing = 0;
  [newlist,remaining] = getallpoints(plane,oldlist,remaining,NPts,DISTTOL,PLANETOL);
  [NewL,W] = size(newlist);
  [OldL,W] = size(oldlist);
  figure(2)
  plot3(newlist(:,1),newlist(:,2),newlist(:,3),'r.')
    
  if NewL > OldL + 1000
    % refit plane
    [newplane,fit] = fitplane(newlist);
    plane = newplane';
    if fit > 0.04*NewL       % bad fit - stop growing
      break
    end
    stillgrowing = 1;
    oldlist = newlist;
    plane = newplane;
  end
end

pause(1)


%plot3(remaining(:,1),remaining(:,2),remaining(:,3),'y.')
plane

end

