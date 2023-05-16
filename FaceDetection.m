clc; 
clear all; 
close all;

% Load the image
img = imread('humans.jpg');

% convert to grayscale
gray_img = rgb2gray(img);

subplot(1, 2, 1);
imshow(gray_img);

% adjust image intensity
gray_img = imadjust(gray_img);

% Apply histogram equalization
gray_img = histeq(gray_img);

% Apply median filtering
gray_img = medfilt2(gray_img, [3 3]);

% Apply contrast stretching
gray_img = imadjust(gray_img);

% Create a face detector object using the Viola-Jones algorithm
faceDetector = vision.CascadeObjectDetector();

% Detect the faces in the image
faces = step(faceDetector, gray_img);

% Draw bounding boxes around the detected faces
m = 0;
for i = 1:size(faces,1)
    m = 1;
    gray_img = insertShape(gray_img, 'Rectangle', faces(i,:), 'LineWidth', 2);
end

% Resize the image to a width of 800 pixels
gray_img = imresize(gray_img, [NaN 800]);

if(m == 1)
    % Display the image with the detected faces
    n=size(faces,1);
    str_n=num2str(n);
    
    str=strcat('number of detected faces: ',str_n);
    
    subplot(1, 2, 2);
    imshow(gray_img);
    title(str);
    
else
    imshow(gray_img);
    title('No face detected');
end




