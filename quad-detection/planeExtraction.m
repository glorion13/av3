function [ oldlist, plane ] = planeExtraction( image )


im3d = image(:,:,1:3);
imRGB= image(:,:,4:6);

initialPtsBinary = hsvThresh(imRGB, 0.8) & hasRangeData(im3d);
inclusiveBagPtsBinary = hsvThresh(imRGB, 1.6) & hasRangeData(im3d);

initialPts = im3d(repmat(initialPtsBinary,[1 1 3]));
inclusiveBagPts = im3d(repmat(inclusiveBagPtsBinary,[1 1 3]));

R = reshape(im3d, 640*480,3); % 3d points
initialPts = reshape(initialPts, length(initialPts)/3,3);
inclusiveBagPts = reshape(inclusiveBagPts, length(inclusiveBagPts)/3,3);

[NPts, ~] = size(R);

% find surface patches
% here just get 5 first planes - a more intelligent process should be
% used in practice. Here we hope the 4 largest will be included in the
% 5 by virtue of their size
remaining = inclusiveBagPts; 

% select a random small surface patch
[oldlist,plane] = select_patch(initialPts);

% grow patch
stillgrowing = 1;

DISTTOL  = 0.01;
PLANETOL = 0.01;   %don't check distance to the closest point

pointsAdded = size( oldlist, 1 );

while stillgrowing

% find neighbouring points that lie in plane

  stillgrowing = 0;
  [newlist,remaining] = getallpoints(plane,oldlist((end-pointsAdded + 1):end,:),remaining,NPts,DISTTOL,PLANETOL);
  
  
  newlist = [ oldlist ; newlist ];
  
  [NewL,W] = size(newlist);
  [OldL,W] = size(oldlist);
  
  pointsAdded = NewL - OldL;
  
  
  if (pointsAdded > 10) % TODO: look at this param
    % refit plane
    [newplane,fit] = fitplane(newlist);
    if fit > 0.04*NewL       % bad fit - stop growing
      break
    end
    stillgrowing = 1;
    oldlist = newlist;
    plane = newplane;
  end
end

end

