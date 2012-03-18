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
backgroundImage = imread(backgroundDir);

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
remapped = zeros(height,width,3,nImages);

% Overlaying background image on the actual video
for i=1: nImages
       
    % Remap field image as background image
    UV=[[40,182]',[39,429]',[474,453]',[474,155]']';    % target points
    remapped(:,:,:,i) = remap(backgroundImage, transformedImages(:,:,:,i), plane, UV);
    
    % Working on quad
    if i > 14 && i < 26
        [ quadPoints ] = planeExtraction(transformedImages(:,:,:,i));
        %suitcase = getCorners(quadPoints);

        % Load corresponding video frame
        listing = dir( videoDir );
        imagePath = strcat(videoDir, '/', listing( i+3 ).name);
        videoFrame = imread(imagePath);

        UV=[[40,182]',[39,429]',[474,453]',[474,155]']';    % target points
        % remap on suitcase
    end
end

