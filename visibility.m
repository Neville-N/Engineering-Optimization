function vis = visibility(bPos, oPos)
% Visibility is modeled as a gausian function based only on the distance
% between boat and object.
    diff = oPos - bPos;
    dist2 = diff(:,1).^2 + diff(:,2).^2;
    c = 33; % 
    vis = exp(-(dist2)/(2*c^2));
end