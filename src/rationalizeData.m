clear; clc;

filenames = {
    '2D-Data/PointsOnBoneLeft45.csv',
    '2D-Data/PointsOnBoneLeft30.csv',
    '2D-Data/PointsOnBoneLeft15.csv',
    '2D-Data/PointsOnBoneRight15.csv',
    '2D-Data/PointsOnBoneRight30.csv',
    '2D-Data/PointsOnBoneRight45.csv',
    };

for i = 1:length(filenames)
    pointsTable = readtable(filenames{i});
    x = pointsTable.X;
    y = pointsTable.Y;
    for r = 1:length(x)
       if y(r) < 1000  % this is a suitable cutoff for NaN points
           x(r) = NaN;
           y(r) = NaN;
       end
    end
    pointsTable.X = x;
    pointsTable.Y = y;
    writetable(pointsTable,filenames{i});
end

