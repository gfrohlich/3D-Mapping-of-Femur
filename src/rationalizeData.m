clear; clc;

filenames = {
    '2D-Data/BonePointsLeft45.csv',
    '2D-Data/BonePointsLeft30.csv',
    '2D-Data/BonePointsLeft15.csv',
    '2D-Data/BonePointsRight15.csv',
    '2D-Data/BonePointsRight30.csv',
    '2D-Data/BonePointsRight45.csv',
    '2D-Data/BonePointsCustom1.csv',
    '2D-Data/BonePointsCustom2.csv'
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

