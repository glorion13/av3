% Main

% Initialize data locations
imagesDir = 'data/bindermat';
backgroundDir = 'data/field.jpg';
xRange = [130, 320];
yRange = [250, 320];

xSize = xRange(2) - xRange(1) + 1;
ySize = yRange(2) - yRange(1) + 1;

% Main loop

% Loading data
images = readData(imagesDir);
backgroundImage = imread(backgroundDir);

% Transforming images so that they are displayed correctly
transformedImages = transformData(images);
earlyFrame = transformedImages(:,:,:,2);

initialPoints = earlyFrame(xRange(1):xRange(2),yRange(1):yRange(2),1:3);
initialPoints = reshape(initialPoints(:,:,1:3), xSize*ySize, 3);

[plane, fit] = fitplane(initialPoints);

P = reshape(earlyFrame(:,:,1:3), 480*640, 3);

[newlist, remaining] = getallpoints(plane, initialPoints, P, length(P));

% Overlaying background image on the actual video
remapped = remap(backgroundImage, transformedImages(:,:,:,3));