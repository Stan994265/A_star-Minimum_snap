close all; clear all; clc;
% Environment map in 2D space 
% set(gca,'xtick',0:1:30);
% set(gca,'ytick',0:1:30);
% set(gca,'ztick',0:1:13);
% set(get(gca,'xLabel'),'String','x(m)');
% set(get(gca,'yLabel'),'String','y(m)');
% set(get(gca,'zLabel'),'String','z(m)');
% legend(X_n,'path');legend(path,'trajectory');legend(xStart,'Start');

xStart = 3.0;
yStart = 3.0;
zStart = 0.0;
xTarget = 28.0;
yTarget = 28.0;
zTarget = 0.0;
MAX_X = 30.0;
MAX_Y = 30.0;
MAX_Z = 10.0;
map = map_build(xStart, yStart,zStart, xTarget, yTarget,zTarget, MAX_X, MAX_Y,MAX_Z);
visualize_map(map, path);

distance=distance(xStart,yStart,xTarget,yTarget);
% Waypoint Generator Using the A* 
path = A_star_search(map, MAX_X,MAX_Y,xTarget, yTarget);
run Minimum_snap;

Z_n=0*ones(size(X_n));
plot(X_n-0.5, Y_n-0.5 ,'r', 'LineWidth', 2);
hold on;
for i = 1:n_seg
    plot([path(i, 1)-0.5,path(i+1, 1)-0.5], [path(i, 2)-0.5 , path(i+1, 2)-0.5],'*-k', 'Linewidth', 1);
end
grid on;
set(gca,'xtick',0:1:30);
set(gca,'ytick',0:1:30);
set(gca,'ztick',0:1:13);
set(get(gca,'xLabel'),'String','x(m)');
set(get(gca,'yLabel'),'String','y(m)');
set(get(gca,'zLabel'),'String','z(m)');
%show vaj planning result
figure(2);
bar(ts);hold on;
set(get(gca,'xLabel'),'String','Segment');
set(get(gca,'yLabel'),'String','Time(s)');
title('Time Segment');
figure(3);
plot(Time,VX_n,'r');hold on;
plot(Time,VY_n,'b');hold on;
set(get(gca,'xLabel'),'String','Time(s)');
set(get(gca,'yLabel'),'String','Velocity(m/s)');
legend('Vel_x','Vel_y');
set(gca,'xgrid','on','ygrid','on');
title('Velocity Planning');     
figure(4);
plot(Time,AX_n,'r');hold on;
plot(Time,AY_n,'b');hold on;
set(get(gca,'xLabel'),'String','Time(s)');
set(get(gca,'yLabel'),'String','Acceleration(m/s^2)');
legend('Acc_x','Acc_y');
set(gca,'xgrid','on','ygrid','on');
title('Acceleration Planning');
figure(5);
plot(Time,JX_n,'r');hold on;
plot(Time,JY_n,'b');hold on;
set(get(gca,'xLabel'),'String','Time(s)');
set(get(gca,'yLabel'),'String','Jerk(m/s^3)');
legend('J_x','J_y');
set(gca,'xgrid','on','ygrid','on');
title('Jerk Planning');