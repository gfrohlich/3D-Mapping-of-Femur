function point = compute3DPoint(cameraParams,imagePoints)
%COMPUTE3DPOINTS Summary of this function goes here
%   Detailed explanation goes here

a = cameraParams;

x = imagePoints(:,1);
y = imagePoints(:,2);

[~,p] = size(a);

B = [];
d = [];

for i = 1:p
    B = [
        B;
        a(1,i)-a(9,i)*x(i) a(2,i)-a(10,i)*x(i) a(3,i)-a(11,i)*x(i);
        a(5,i)-a(9,i)*y(i) a(6,i)-a(10,i)*y(i) a(7,i)-a(11,i)*y(i);
    ];

    d = [
        d;
        x(i)-a(4,i);
        y(i)-a(8,i);
    ];
end

x = B\d;

point = x';

end

