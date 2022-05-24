function animate(objectPath, boatPath, timeDelay, dt, X, Y, U, V)
figure(10)
% quiver(X, Y, U, V)

plot(objectPath(:,1), objectPath(:,2))
hold on
plot(boatPath(:,1), boatPath(:,2))

o = plot(objectPath(1,1), objectPath(1,2),'o','MarkerFaceColor','blue');
b = plot(boatPath(1,1), boatPath(1,2),'o','MarkerFaceColor','red');
hold off
axis tight equal
Ndelay = int32(timeDelay/dt);

for k = 2:length(objectPath(:,1))
    o.XData = objectPath(k,1);
    o.YData = objectPath(k,2);
    if k>Ndelay
        b.XData = boatPath(k-Ndelay,1);
        b.YData = boatPath(k-Ndelay,2);
    end
    drawnow
end
end