% find a candidate planar patch
function [fitlist,plane] = select_patch(points)

  [L,D] = size(points);
  tmpnew = zeros(L,3);
  tmprest = zeros(L,3);
  
  residErrTol = 0.005;

  % pick a random point until a successful plane is found
  success = 0;
  while ~success
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
      fitcount
      resid
      
      residErrTol = residErrTol + 0.00002;
      
      if resid < residErrTol
        fitlist = tmpnew(1:fitcount,:);
        return
      end
    end
  end  
