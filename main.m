% Main

% Initialize data locations
imagesDir = 'data/bindermat';
backgroundDir = 'data/field.jpg';
videoDir = 'data/video';

% manually selected corners of the overlaying background image
backgroundCorners=[[40,182]',[39,429]',[474,453]',[474,155]']';

% Loading data
images = readData(imagesDir);
backgroundImage = double(imread(backgroundDir));

[width,height,nChannels,nImages] = size(images);

% Transforming images so that they are displayed correctly
images = transformData(images);
earlyFrame = images(:,:,:,2);

writeImgs(images,1:nImages, 'original');

% Find a big patch for estimating the plane based on the four corners
sizePatch= 100;
middlePoint = round(mean(backgroundCorners));
xRange = [middlePoint(1)-sizePatch, middlePoint(1)+sizePatch];
yRange = [middlePoint(2)-sizePatch, middlePoint(2)+sizePatch];
xSize = xRange(2) - xRange(1) + 1;
ySize = yRange(2) - yRange(1) + 1;

% Compute Background overlaying plane
initialPoints = earlyFrame(xRange(1):xRange(2),yRange(1):yRange(2),1:3);
initialPoints = reshape(initialPoints(:,:,1:3), xSize*ySize, 3);

[plane, fit] = fitplane(initialPoints);


% Iterate over the images
for i=1: nImages
    
    frame = i
        
    % In case of a very improbable event of not finding the best fitting
    % plane, while there is one, run the algorithm again
    for j=1:2      
        attempt = j
        [ quadPoints, suitcasePlane ] = planeExtraction(images(:,:,:,i));
        if isSuitcase(quadPoints)
            break;
        end
    end

    if isSuitcase(quadPoints)
        % find ordered corners of the suitcase
        suitcaseCorners = getCorners(quadPoints);
        pixelVals = getPixelVals(suitcaseCorners, images(:,:,:,i));
        orderedCorners = orderCorners(pixelVals);

        % Load corresponding video frame
        listing = dir( videoDir );
        imagePath = strcat(videoDir, '/', listing( i+3 ).name);
        videoFrame = double(imread(imagePath));

        % Remap video on the suitcase
        images(:,:,:,i) = remap(videoFrame, images(:,:,:,i), suitcasePlane, orderedCorners, 0.02);
    end

    writeImgs(images,i, 'quad');
    
    % Make pixels without any value into background pixels
    images(:,:,:,i) = fillMissingVals(images(:,:,:,i), earlyFrame(:,:,4:6));
    writeImgs(images,i, 'fill');   
    
    % Remap field image as background image
    UV=backgroundCorners;    % target points
    images(:,:,:,i) = remap(backgroundImage, images(:,:,:,i), plane, UV, 0.05);
    
    imshow(images(:,:,4:6,i));
end

% create the AV.avi video of all the frames
generateVideo(images);

% write all the final images to the output folder
writeImgs(images,1:nImages, 'final');
