function [ oldlist ] = planeExtraction( points3d )

R = points3d;
figure(1)
clf
hold on
plot3(R(:,1),R(:,2),R(:,3),'k.')

[NPts,W] = size(R);
plane = zeros(20);

% find surface patches
% here just get 5 first planes - a more intelligent process should be
% used in practice. Here we hope the 4 largest will be included in the
% 5 by virtue of their size
remaining = R; 

% select a random small surface patch
[oldlist,plane] = select_patch(remaining);

% grow patch
stillgrowing = 1;

while stillgrowing

% find neighbouring points that lie in plane
  stillgrowing = 0;
  [newlist,remaining] = getallpoints(plane,oldlist,remaining,NPts);
  [NewL,W] = size(newlist);
  [OldL,W] = size(oldlist);
  plot3(newlist(:,1),newlist(:,2),newlist(:,3),'r.')
 
pause(1)
    
  if NewL > OldL + 50
    % refit plane
    [newplane,fit] = fitplane(newlist);
[newplane',fit,NewL]
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

