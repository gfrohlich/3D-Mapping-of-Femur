
close all; clear; clc;

%% Define Control Points

controlPointsKnown = [
    3.49,  3.92, 5.43;
    8.49,  3.90, 5.82;
    4.48,  5.32, 5.96;
    9.40,  5.78, 6.83;
    4.10,  7.08, 7.31;
    9.65,  9.41, 5.45;
    5.92, 10.38, 5.97;
    8.58, 11.56, 6.76;
];

[numControlPoints,~] = size(controlPointsKnown);

%% Image Selection

fprintf('Would you like to use the provided images or the custom images?\n');
fprintf('  1. Provided images\n');
fprintf('  2. Custom images\n');
groupSelection = input('Selection: ');
switch groupSelection
    case 1 
        imageNames = {
            'Left15'
            'Left30'
            'Left45'
            'Right15'
            'Right30'
            'Right45'
            };
    case 2
        imageNames = {
            'Custom1'
            'Custom2'
            };
    otherwise
        error('Invalid image group.');
end

fprintf('Which combination of images would you like to use?\n');
for i = 1:length(imageNames)
    fprintf('  %i. %s\n', i, imageNames{i});
end
imageSelections = eval(['[' input('Selections: ', 's') ']']);
numCameras = length(imageSelections);

%% Read Image Data

controlPoints = {};
bonePoints    = {};
a = {};

for i = 1:numCameras
    % Read image points
    imageName = imageNames{imageSelections(i)};
    controlPointsTable = readtable(['2D-Data/ControlPoints', imageName, '.csv']);
    bonePointsTable    = readtable(['2D-Data/BonePoints',    imageName, '.csv']);
    controlPoints{i} = [controlPointsTable.X, controlPointsTable.Y];
    bonePoints{i}    = [bonePointsTable.X,    bonePointsTable.Y];
    % Compute camera params
    a{i} = computeCameraParams(controlPointsKnown, controlPoints{i});
end

numBonePoints = length(bonePoints{1});

% Combine camera param vectors (a) into matrix (A)
A = [];
for i = 1:numCameras
    A = [A, a{i}];
end

%% Compute Control Points

controlPointsComputed = [];
for i = 1:numControlPoints
    controlPointPoints = [];
    for j = 1:numCameras
        controlPointPoints = [controlPointPoints; controlPoints{j}(i,:)];
    end
    controlPointsComputed = [controlPointsComputed; compute3DPoint(A, controlPointPoints)];
end

%% Error Calculations

controlPointsErrors = (controlPointsComputed - controlPointsKnown) ./ controlPointsKnown * 100;

%% Plot Screws in 3D

x = controlPointsComputed(:,1);
y = controlPointsComputed(:,2);
z = controlPointsComputed(:,3);

xe = controlPointsErrors(:,1);
ye = controlPointsErrors(:,2);
ze = controlPointsErrors(:,3);

for i = 1:numControlPoints
    plot3([x(i) x(i)], [y(i) y(i)], [0 z(i)]);
    text(x(i), y(i), z(i),sprintf('M%i (%+.2f, %+.2f, %+.2f) %%', i, xe(i), ye(i), ze(i)));
    hold on
end

title('Screws Computed')
xlabel('x')
ylabel('y')
zlabel('z')
grid on

%% Compute Bone Surface Points

bonePointsComputed = [];
for i = 1:numBonePoints
    bonePointPoints = [];
    for j = 1:numCameras
        bonePointPoints = [bonePointPoints; bonePoints{j}(i,:)];
    end
    bonePointsComputed = [bonePointsComputed; compute3DPoint(A, bonePointPoints)];
end

%% Plot Bone Surface in 3D

% TODO
