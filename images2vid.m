function [  ] = images2vid(  )
    
    numImages = 10;
    filename{numImages} = {};
    filename(:) = {'depth_grey_0011.tif'};
    
    for i = 1 : numImages
        
        % generate an image from somewhere
        im = imread(filename{i});
        imshow(im);
        
        % get a movie frame (a snapshot of the current axis)
        M(i) = getframe(gcf);
    end
    
    % write movie object to disk
    fps = 5;
    movie2avi(M, 'AV_movie.avi', 'FPS', fps);

end

