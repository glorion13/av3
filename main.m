% Main

% Initialize data locations
imagesDir = 'data/bindermat';
backgroundDir = 'data/field.jpg';

% Main loop

% Loading data
images = readData(imagesDir);
backgroundImage = imread(backgroundDir);

% Transforming images so that they are displayed correctly
transformedImages = transformData(images);

% Overlaying background image on the actual video
remapped = remap(backgroundImage, transformedImages(:,:,:,3));