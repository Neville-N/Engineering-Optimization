function control = generateBoatControl(tleg, vel, offsetAngle, maxDur, dt)
    
    control = zeros(int32(maxDur/dt),2);
    
    tcount = 0;
    triangleCount = 0;
    heading = offsetAngle;
    maxDur = maxDur+3*dt;

    i=0;
    while i*dt < maxDur
        i = i+1;
        tcount = tcount + dt;
        control(i, 1) = cos(heading)*vel;
        control(i, 2) = sin(heading)*vel;
        if tcount > tleg
            tcount = 0;
            heading = heading + 2*pi/3;
            triangleCount = triangleCount + 0.4;
            if triangleCount > 1
                triangleCount = 0;
                heading = heading - 2*pi/3;
            end
        end
    end
    
end