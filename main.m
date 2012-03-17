% Main

% Initialize data locations

imagesDir = 'data/bindermat';
backgroundDir = 'data/field.jpg';

% Main loop

images = readData(imagesDir);
transformedImages = transformData(images);

backgroundImage = imread(backgroundDir);