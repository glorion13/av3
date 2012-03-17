% Main

% Initialize data locations
imagesDir = 'data/bindermat';
backgroundDir = 'data/field.jpg';
initialPointsXY = [87,176; 90,371;402,144;407,400]; % image (x, y)



% Main loop

% Loading data
images = readData(imagesDir);
backgroundImage = imread(backgroundDir);

% Transforming images so that they are displayed correctly
transformedImages = transformData(images);
initialPoints = getRange(transformedImages(:,:,:,2), initialPointsXY);

% Overlaying background image on the actual video
remapped = remap(backgroundImage, transformedImages(:,:,:,3));