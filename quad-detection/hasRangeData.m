function [ binary ] = hasRangeData( pts3d )
% Returns a logical of all the points which have some range data.

ranges = pts3d(:,:,3);
binary = ranges ~= 0;

end

