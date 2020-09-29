function path = A_star_search(map,MAX_X,MAX_Y,xTarget, yTarget)
%%
% Environment map in 2D space 
% xStart = 1.0;
% yStart = 1.0;
% xTarget = 9.0;
% yTarget = 9.0;
% MAX_X = 10;
% MAX_Y = 10;
% map = obstacle_map(xStart, yStart, xTarget, yTarget, MAX_X, MAX_Y);
%This part is about map/obstacle/and other settings
    %pre-process the grid map, add offset
    size_map = size(map,1);
    Y_offset = 0;
    X_offset = 0;
    
    %Define the 2D grid map array.
    %Obstacle=-1, Target = 0, Start=1
    MAP=2*(ones(MAX_X,MAX_Y));
    
    %Initialize MAP with location of the target
    xval=floor(map(size_map, 1)) + X_offset;
    yval=floor(map(size_map, 2)) + Y_offset;
    xTarget=xval;
    yTarget=yval;
    MAP(xval,yval)=0;
    
    %Initialize MAP with location of the obstacle
    for i = 2: size_map-1
        xval=floor(map(i, 1)) + X_offset;
        yval=floor(map(i, 2)) + Y_offset;
        MAP(xval,yval)=-1;
    end 
    
    %Initialize MAP with location of the start point
    xval=floor(map(1, 1)) + X_offset;
    yval=floor(map(1, 2)) + Y_offset;
    xStart=xval;
    yStart=yval;
    MAP(xval,yval)=1;

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %LISTS USED FOR ALGORITHM
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %OPEN LIST STRUCTURE
    %--------------------------------------------------------------------------
    %IS ON LIST 1/0 |X val |Y val |Parent X val |Parent Y val |h(n) |g(n)|f(n)|
    %--------------------------------------------------------------------------
    OPEN=[];
    %CLOSED LIST STRUCTURE
    %--------------
    %X val | Y val |
    %--------------
    % CLOSED=zeros(MAX_VAL,2);
    CLOSED=[];

    %Put all obstacles on the Closed list
    k=1;%Dummy counter
    for i=1:MAX_X
        for j=1:MAX_Y
            if(MAP(i,j) == -1)
                CLOSED(k,1)=i;
                CLOSED(k,2)=j;
                k=k+1;
            end
        end
    end
    CLOSED_COUNT=size(CLOSED,1);
    %set the starting node as the first node
    xNode=xval;
    yNode=yval;
    OPEN_COUNT=1;
    goal_distance=distance(xNode,yNode,xTarget,yTarget);
    path_cost=0;
    OPEN(OPEN_COUNT,:)=insert_open(xNode,yNode,xNode,yNode,goal_distance,path_cost,goal_distance);
    OPEN(OPEN_COUNT,1)=0;
    CLOSED_COUNT=CLOSED_COUNT+1;
    CLOSED(CLOSED_COUNT,1)=xNode;
    CLOSED(CLOSED_COUNT,2)=yNode;
    NoPath=1;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% START ALGORITHM
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %i=2; 
    path=[];
    path_count=1;
    path(path_count,1)=xNode;
    path(path_count,2)=yNode;
    weight=1000000000;
    while(xNode~=xTarget||yNode~=yTarget) % the Conditions for while loop
       % i_min=min_fn(OPEN,OPEN_COUNT,xTarget,yTarget);
        gn=distance(xStart,yStart,xNode,yNode);
        exp_array=expand_array(xNode,yNode,gn,xTarget,yTarget,MAP,MAX_X,MAX_Y);
        num=size(exp_array,1);
        for exp_count=1:num
          xTem=exp_array(exp_count,1);
          yTem=exp_array(exp_count,2);
          %fn=exp_array(exp_count,5) ;
          hn=weight*exp_array(exp_count,3) ;  
          path_cost=exp_array(exp_count,4) ;
          %k=5;
          fn=hn+path_cost;
          OPEN_COUNT=OPEN_COUNT+1;
          OPEN(OPEN_COUNT,:)=insert_open(xTem,yTem,xNode,yNode,hn,path_cost,fn);         
        end
        
%         OPEN(OPEN_COUNT,1)=OPEN_COUNT; 
%         OPEN_COUNT=OPEN_COUNT+1;
        i_min=min_fn(OPEN,OPEN_COUNT,xTarget,yTarget);
        xNode=OPEN(i_min,2);
        yNode=OPEN(i_min,3);
        CLOSED_COUNT=CLOSED_COUNT+1;
        CLOSED(CLOSED_COUNT,1)=xNode;
        CLOSED(CLOSED_COUNT,2)=yNode;
%         OPEN(OPEN_COUNT,:)=insert_open(xNode,yNode,xNode,yNode,goal_distance,path_cost,goal_distance);
%         OPEN(OPEN_COUNT,1)=OPEN_COUNT; 
%         OPEN_COUNT=OPEN_COUNT+1;
        path_count=path_count+1;
        path(path_count,1)=xNode;
        path(path_count,2)=yNode;
        OPEN_COUNT=1;
    end
    
    %寻找拐点
    path_=[];
    path_(1,1)=path(1,1);
    path_(1,2)=path(1,2);
    path_count_=1;
    for j=1:path_count-2
        d1=distance(path(j,1),path(j,2),path(j+1,1),path(j+1,2));
        d2=distance(path(j+1,1),path(j+1,2),path(j+2,1),path(j+2,2));
        if (d1~=d2)
            path_count_=path_count_+1;
            path_(path_count_,1)=path(j+1,1);
            path_(path_count_,2)=path(j+1,2);
        end
    end
    path_(path_count_+1,1)=path(path_count,1);
    path_(path_count_+1,2)=path(path_count,2);
end
    

   

