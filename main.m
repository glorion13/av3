% Main

% Initialize data locations
imagesDir = 'data/bindermat';
backgroundDir = 'data/field.jpg';
videoDir = 'data/video';

xRange = [130, 320];
yRange = [250, 320];

xSize = xRange(2) - xRange(1) + 1;
ySize = yRange(2) - yRange(1) + 1;

% Main loop

% Loading data
images = readData(imagesDir);
backgroundImage = double(imread(backgroundDir));

[width,height,nChannels,nImages] = size(images);

% Transforming images so that they are displayed correctly
transformedImages = transformData(images);
earlyFrame = transformedImages(:,:,:,2);

initialPoints = earlyFrame(xRange(1):xRange(2),yRange(1):yRange(2),1:3);
initialPoints = reshape(initialPoints(:,:,1:3), xSize*ySize, 3);

[plane, fit] = fitplane(initialPoints);

%P = reshape(earlyFrame(:,:,1:3), 480*640, 3);
%[newlist, remaining] = getallpoints(plane, initialPoints, P, length(P));
% [plane, fit] = fitplane(newlist);
remapped = zeros(height,width,6,nImages);

% Overlaying background image on the actual video
for i=1: nImages
    
    i
       
    % Remap field image as background image
    UV=[[40,182]',[39,429]',[474,453]',[474,155]']';    % target points
    remapped(:,:,:,i) = remap(backgroundImage, transformedImages(:,:,:,i), plane, UV, 0.05);
    
    % Working on quad
    if i > 13 && i < 29
        
        for j=1:3
            frame = i
            attempt = j
            [ quadPoints, suitcasePlane ] = planeExtraction(transformedImages(:,:,:,i));
            if isSuitcase(quadPoints)
                break;
            end
        end
        suitcaseCorners = getCorners(quadPoints);
        
        pixelVals = getPixelVals(suitcaseCorners, transformedImages(:,:,:,i));
        orderedCorners = orderCorners(pixelVals);
        
        if isSuitcase(quadPoints)
        
            % Load corresponding video frame
            listing = dir( videoDir );
            imagePath = strcat(videoDir, '/', listing( i+3 ).name);
            videoFrame = double(imread(imagePath));

            % remap on suitcase
            remapped(:,:,:,i) = remap(videoFrame, remapped(:,:,:,i), suitcasePlane, orderedCorners, 0.02);
            figure(3)
            imshow(remapped(:,:,4:6,i))
            figure(1)
        end
            
            
    end
end

