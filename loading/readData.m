function [ images ] = readData( path )
    
    % Loads a sequence of images from a given 'path' (a string specifying a
    % path to a folder).

    listing = dir( path );

    nImages    = size( listing, 1 ) - 3;
    images     = zeros( 640, 480, 6, nImages);


    for i = 1 : nImages
        var=importdata( [ path '/' listing( i+3 ).name ] );
        images( :, :, :, i ) = reshape(var, 640,480,6);
    end

end