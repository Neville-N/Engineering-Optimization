function [path, vel] = getBoatPath(sideLength, gridStep,gridRes, Uinterp, Vinterp, boatControl, maxDur, dt)
initSize = 2;
pos = zeros(initSize,2);
startX = sideLength / 2;
startY = sideLength / 2;
pos(1, 1) = startX;
pos(1, 2) = startY;

xIndex = zeros(initSize,1,'int16');
yIndex = zeros(initSize,1,'int16');
xIndex(1) = int32(pos(1,1)/gridStep);
yIndex(1) = int32(pos(1,2)/gridStep);

dxdt = zeros(initSize, 1);
dydt = zeros(initSize, 1);

dxdt(1) = Uinterp(pos(1,:));
dydt(1) = Vinterp(pos(1,:));

i = 1;
while true
    i = i+1;
    dxdt(i) = Uinterp(pos(i-1,:)) + boatControl(i, 1);
    dydt(i) = Vinterp(pos(i-1,:)) + boatControl(i, 2);

    pos(i,1) = pos(i-1,1) + dxdt(i)*dt;
    pos(i,2) = pos(i-1,2) + dydt(i)*dt;

    xIndex(i) = int16(pos(i,1)/gridStep)+1;
    yIndex(i) = int16(pos(i,2)/gridStep)+1;
    if xIndex(i) < 1 || xIndex(i) > gridRes+1
        pos(i:end, 1) = pos(i,1);
        pos(i:end, 2) = pos(i,2);
        disp('Path outside field');
        break
    end
    if yIndex(i) < 1 || yIndex(i) > gridRes
        pos(i:end, 1) = pos(i,1);
        pos(i:end, 2) = pos(i,2);
        disp('Path outside field');
        break
    end
    if i*dt>maxDur
        disp('Max number of steps reached.')
        break
    end
    if dxdt(i)^2+dydt(i)^2 < 1e-5
        disp('speed limit')
        break
    end
end
path = pos;
vel = [dxdt, dydt];
end