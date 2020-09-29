function map = map_build(xStart, yStart,zStart, xTarget, yTarget,zTarget, MAX_X, MAX_Y,MAX_Z)
    rand_map = rand(MAX_X,MAX_Y);
    map = [];
    map(1,1) = xStart;
    map(1,2) = yStart;
    map(1,3) = zStart;
    k=2;
    obstacle_ratio = 0.2;
    for i = 1:1:MAX_X
        for j = 1:1:MAX_Y            
            if( (rand_map(i,j) < obstacle_ratio) && (i~= xStart || j~=yStart) && (i~= xTarget || j~=yTarget))
                h=randi(MAX_Z);
                for u=1:h
                    map(k,1) = i;
                    map(k,2) = j;
                    map(k,3)=u;
                    k=k+1;
                end    
                
            end 
        end                   
    end
      
    map(k,1) = xTarget;
    map(k,2) = yTarget;
    map(k,3) = zTarget;
    
    
end


