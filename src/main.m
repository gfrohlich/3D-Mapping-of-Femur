close all; clear; clc;
%% Define Control Points

controlPoints = [
    3.49,  3.92, 5.43;
    8.49,  3.90, 5.82;
    4.48,  5.32, 5.96;
    9.40,  5.78, 6.83;
    4.10,  7.08, 7.31;
    9.65,  9.41, 5.45;
    5.92, 10.88, 5.97;
    8.58, 11.56, 6.76;
];

[numControlPoints,~] = size(controlPoints);

%% Image Selection

filenames = {
    '2D-Data/PointSelectionTableLeft15.csv',
    '2D-Data/PointSelectionTableLeft30.csv',
    '2D-Data/PointSelectionTableLeft45.csv',
    '2D-Data/PointSelectionTableRight15.csv',
    '2D-Data/PointSelectionTableRight30.csv',
    '2D-Data/PointSelectionTableRight45.csv',
    };

fprintf('Select 2 images to create the 3D map.\n');
for i = 1:length(filenames)
    fprintf('  %i. %s\n', i, filenames{i});
end
fileSelection1 = input('Selection 1: ');
fileSelection2 = input('Selection 2: ');

imagePointsTable1 = readtable(filenames{fileSelection1});
imagePoints1 = [imagePointsTable1.X, imagePointsTable1.Y];

imagePointsTable2 = readtable(filenames{fileSelection2});
imagePoints2 = [imagePointsTable2.X, imagePointsTable2.Y];

%% Compute Camera Parameters

a1 = computeCameraParams(controlPoints, imagePoints1);

a2 = computeCameraParams(controlPoints, imagePoints2);

%% Compute 3D Points

cameraParams = [a1 a2];

controlPointsComputed = [];

for i = 1 : numControlPoints
    imagePoints = [
      imagePoints1(i,:);
      imagePoints2(i,:);
    ];
    controlPointsComputed = [
        controlPointsComputed;
        compute3DPoint(cameraParams, imagePoints)';
    ];
end

%% Test Plot Screws in 3D

x = controlPointsComputed(:,1);
y = controlPointsComputed(:,2);
z = controlPointsComputed(:,3);

for i = 1:numControlPoints
plot3([x(i) x(i)], [y(i) y(i)], [0 z(i)]);
text(x(i), y(i), z(i),sprintf('M%i',i));
hold on
end

title('Screws Computed')
xlabel('x')
ylabel('y')
zlabel('z')
grid on
