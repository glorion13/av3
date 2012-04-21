% selects all points in pointlist P that fit the plane and are within
% TOL of a point already in the plane (oldlist)
function [newlist,remaining] = getallpoints(plane,oldlist,P,NP, DISTTOL,PLANETOL)

  pnt = ones(4,1);
  [N,W] = size(P);
  [Nold,W] = size(oldlist);

  tmpnewlist = zeros(NP,3);
 % tmpnewlist(1:Nold,:) = oldlist;       % initialize fit list
  tmpremaining = zeros(NP,3);           % initialize unfit list
  countnew = 0; %Nold;
  countrem = 0;
 
  for i = 1 : N
    pnt(1:3) = P(i,:);
    notused = 1;


    if abs(pnt'*plane) < PLANETOL
        if any( sum( (oldlist - repmat( P(i,:), Nold,1 ) ) .^ 2, 2 ) < DISTTOL * DISTTOL )
            countnew = countnew + 1;
            tmpnewlist(countnew,:) = P(i,:);
            notused = 0;
        end
    end
  
    if notused
      countrem = countrem + 1;
      tmpremaining(countrem,:) = P(i,:);
    end
  end

  newlist = tmpnewlist(1:countnew,:);
  remaining = tmpremaining(1:countrem,:);
countnew
countrem
Nold

