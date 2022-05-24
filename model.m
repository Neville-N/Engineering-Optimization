% Model
clear, close all

sideLength = 5000; % m
maxVelocityMag = 5; % m/s
gridStep = 100; %m
dt = 1; %sz
timeDelay = 1000; %s
Ndelay = int32(timeDelay/dt);

%Boat params
tleg = 10; %s
boatVelMag = 2.5; % m/s
maxDur = 9800-timeDelay; %s

[X, Y, U, V, Xcors, Ycors] = createVecField(sideLength, gridStep, maxVelocityMag);
nums = diag(X)';
gridRes = size(nums,2);

% Create interpolation functions for flow speeds.
[Xnd, Ynd] = ndgrid(nums, nums);
Uinterp = griddedInterpolant(Xnd, Ynd, U, 'linear');
Vinterp = griddedInterpolant(Xnd, Ynd, V, 'linear');

Umiddle = Uinterp(sideLength/2, sideLength/2);
Vmiddle = Vinterp(sideLength/2, sideLength/2);
boatHeading0 = atan2(Vmiddle, Umiddle); % Start boat in direction of waterflow

[oPath, oVel] = getObjectPath(sideLength, gridStep,gridRes, Uinterp, Vinterp, maxDur, dt);

boatControl = generateBoatControl(tleg,boatVelMag,boatHeading0,maxDur, dt);
[bPath, bVel] = getBoatPath(sideLength, gridStep, gridRes, Uinterp, Vinterp, boatControl, maxDur, dt);

% Make equal length paths starting after timedelay
minL = min(length(oPath), length(bPath));
oPath2 = oPath(Ndelay:minL,:);
bPath2 = bPath(Ndelay:minL,:);

visScores = visibility(bPath2, oPath2);
