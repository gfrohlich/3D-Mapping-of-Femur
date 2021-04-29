
imageName = 'Right45';

sourceFilename = ['Images/' imageName '.JPG'];
targetFilename = ['Images/' imageName 'Sharpened.JPG'];

imageData = rgb2gray(imread(sourceFilename));

imageDataSharpened = imsharpen(imageData,'Radius',16,'Amount',10);
imwrite(imageDataSharpened, targetFilename);
