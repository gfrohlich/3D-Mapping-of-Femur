function cameraParams = computeCameraParams(controlPoints,imagePoints)
%COMPUTECAMERAPARAMS Summary of this function goes here
%   Detailed explanation goes here

X = controlPoints(:,1);
Y = controlPoints(:,2);
Z = controlPoints(:,3);

x = imagePoints(:,1);
y = imagePoints(:,2);

C = [
    X(1) Y(1) Z(1) 1 0 0 0 0 -x(1)*X(1) -x(1)*Y(1) -x(1)*Z(1);
    0 0 0 0 X(1) Y(1) Z(1) 1 -y(1)*X(1) -y(1)*Y(1) -y(1)*Z(1);
    
    X(2) Y(2) Z(2) 1 0 0 0 0 -x(2)*X(2) -x(2)*Y(2) -x(2)*Z(2);
    0 0 0 0 X(2) Y(2) Z(2) 1 -y(2)*X(2) -y(2)*Y(2) -y(2)*Z(2);
    
    X(3) Y(3) Z(3) 1 0 0 0 0 -x(3)*X(3) -x(3)*Y(3) -x(3)*Z(3);
    0 0 0 0 X(3) Y(3) Z(3) 1 -y(3)*X(3) -y(3)*Y(3) -y(3)*Z(3);
    
    X(4) Y(4) Z(4) 1 0 0 0 0 -x(4)*X(4) -x(4)*Y(4) -x(4)*Z(4);
    0 0 0 0 X(4) Y(4) Z(4) 1 -y(4)*X(4) -y(4)*Y(4) -y(4)*Z(4);
    
    X(5) Y(5) Z(5) 1 0 0 0 0 -x(5)*X(5) -x(5)*Y(5) -x(5)*Z(5);
    0 0 0 0 X(5) Y(5) Z(5) 1 -y(5)*X(5) -y(5)*Y(5) -y(5)*Z(5);
    
    X(6) Y(6) Z(6) 1 0 0 0 0 -x(6)*X(6) -x(6)*Y(6) -x(6)*Z(6);
    0 0 0 0 X(6) Y(6) Z(6) 1 -y(6)*X(6) -y(6)*Y(6) -y(6)*Z(6);
    
    X(7) Y(7) Z(7) 1 0 0 0 0 -x(7)*X(7) -x(7)*Y(7) -x(7)*Z(7);
    0 0 0 0 X(7) Y(7) Z(7) 1 -y(7)*X(7) -y(7)*Y(7) -y(7)*Z(7);
    
    X(8) Y(8) Z(8) 1 0 0 0 0 -x(8)*X(8) -x(8)*Y(8) -x(8)*Z(8);
    0 0 0 0 X(8) Y(8) Z(8) 1 -y(8)*X(8) -y(8)*Y(8) -y(8)*Z(8);
];

b = [
    x(1);
    y(1);
    x(2);
    y(2);
    x(3);
    y(3);
    x(4);
    y(4);
    x(5);
    y(5);
    x(6);
    y(6);
    x(7);
    y(7);
    x(8);
    y(8);
];

a = C \ b;

cameraParams = a;

end

