function M = images2vid( ims )
    
    numImages = 36;
    
    for i = 1 : numImages
        
        % generate an image from somewhere
        im = ims(:,:,4:6,i);
        imshow(im);
        
        % get a movie frame (a snapshot of the current axis)
        M(i) = getframe(gcf);
        pause(0.6)
    end
    
    % write movie object to disk
    fps = 5;
    movie2avi(M, 'AV_movie.avi', 'FPS', fps);

end