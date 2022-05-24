clear, close all
rng(3)
model

figure(1)
yyaxis left
plot(visScores)
ylabel('Current visibility score')
yyaxis right
plot(cumsum(visScores))
ylabel('Cumulative visibility score')
axis tight


figure(2)
hold on
quiver(X', Y', U, V, 1)
plot(oPath(:,1), oPath(:,2))
plot(bPath(:,1), bPath(:,2))
axis equal tight
hold off

% animate(oPath, bPath, timeDelay, dt, X, Y, U, V);