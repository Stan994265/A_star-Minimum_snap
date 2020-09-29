function visualize_map(map,path)
%This function visualizes the 2D grid map 
%consist of obstacles/start point/target point/optimal path.
    % obstacle
    t =size(map,1);
    x_=map(2:t-1,1);
    y_=map(2:t-1,2);
    z_=map(2:t-1,3);
    c = linspace(1,10,length(z_));%using z_ for color  
    for i=2:t-1
        draw_cube(map(i,1)-1 ,map(i,2)-1, map(i,3)-1,1,1,1,[map(i,3)]);
    end

    axis equal;        
    axis ([0 31 0 31 0 13]);
    hold on;
    
    % start point
    scatter3(map(1, 1)-0.5, map(1, 2)-0.5,map(1, 3),200,'b','p','filled');
    grid minor;
    % target point
	scatter3(map(size(map, 1), 1)-0.5, map(size(map, 1), 2)-0.5,map(size(map, 1), 3), 200,'b','p','filled');
    grid minor;

end

