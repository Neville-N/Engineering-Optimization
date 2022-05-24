%  Function to create vector field.
function [X, Y, U, V, Xcors, Ycors] = createVecField(sideLength, gridStep, mag)
%     dgrid = sideLength/gridRes;
    
    Nvecs = int16(sideLength/gridStep)+1;
    Xcors = linspace(0,sideLength,Nvecs);
    Ycors = linspace(0,sideLength,Nvecs);
    
    [X,Y] = meshgrid(Xcors, Ycors);

    % perlin nois with higher diagonal speeds
    U = mag*(perlin2D(Nvecs)-0.5);
    V = mag*(perlin2D(Nvecs)-0.5);
end

function s = perlin2D (m)
  s = zeros([m,m]);     % Prepare output image (size: m x m)
  w = m;
  i = 0;
  while w > 3
    i = i + 1;
    d = interp2(randn([m,m]), i-1, 'spline');
    s = s + i * d(1:m, 1:m);
    w = w - ceil(w/2 - 1);
  end
  s = (s - min(min(s(:,:)))) ./ (max(max(s(:,:))) - min(min(s(:,:))));
end