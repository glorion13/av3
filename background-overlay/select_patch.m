% find a candidate planar patch
function [fitlist,plane] = select_patch(points)

  [L,D] = size(points);
  tmpnew = zeros(L,3);
  tmprest = zeros(L,3);
  
  initialErrTol = 0.01;
  maximumErrTol = 0.04;
  nSteps        = 500;
  
  residErrTol   = initialErrTol;
  stepSize      = (maximumErrTol - initialErrTol) / nSteps;
  % pick a random point until a successful plane is found or no plane can
  % be found (allow for 500 random point selections)
  for i=1:nSteps 
    idx = floor((L-1)*rand)+1;   % avoiding accesing element at 0
    pnt = points(idx,:);

    
    % find points in the neighborhood of the given point
    DISTTOL = 0.08;
    fitcount = 0;
    restcount = 0;
    for i = 1 : L
      dist = norm(points(i,:) - pnt);
      if dist < DISTTOL
        fitcount = fitcount + 1;
        tmpnew(fitcount,:) = points(i,:);
      else
        restcount = restcount + 1;
        tmprest(restcount,:) = points(i,:);
      end
    end
    oldlist = tmprest(1:restcount,:);

    if fitcount > 1500
      % fit a plane
      [plane,resid] = fitplane(tmpnew(1:fitcount,:));
      %fitcount
      %resid
      
      if resid < residErrTol
        fitlist = tmpnew(1:fitcount,:);
        return
      end
    end
    
    %increase allowed error tolerance
    residErrTol = residErrTol + stepSize;
  end
  
  % no plane found - return points which will fail.
  fitlist=oldlist;
  plane=[1; 1; 1; 1];
