function [newlist,remaining] = getallpoints(plane,oldlist,P,NP, DISTTOL,PLANETOL)
% selects all points in pointlist P that fit the plane and are within
% TOL of points added newly to the list of points in the plane.

  pnt = ones(4,1);
  [N,W] = size(P);
  [Nold,W] = size(oldlist);

  tmpnewlist = zeros(NP,3);
  tmpremaining = zeros(NP,3);           % initialize unfit list
  countnew = 0; %Nold;
  countrem = 0;
 
  for i = 1 : N
    pnt(1:3) = P(i,:);
    notused = 1;


    if abs(pnt'*plane) < PLANETOL
        % speed optimisation of vectorising the for loop was suggested 
        % by Cristian Cobzarenco
        if any( sum((oldlist - repmat( P(i,:), Nold,1)) .^ 2, 2 ) < DISTTOL^2 )
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

