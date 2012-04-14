function generateVideo(remapped)

    % Generates a video from the individual frames

    vw = VideoWriter('AV_movie.avi');
    vw.FrameRate = 6;
    vw.open();

    for i = 1:36
        image = remapped(:,:,4:6,i);
        imshow(image);
        writeVideo(vw,getframe(gcf));
    end

    close(vw);
end