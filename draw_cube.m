function draw_cube(x0,y0,z0,lx,ly,lz,k)
%x0=1;y0=1;z0=1;lx=3;ly=3;lz=3;k='r';
x=zeros(6,5);y=zeros(6,5);z=zeros(6,5);
x=[x0 x0+lx x0+lx x0 x0;
    x0 x0 x0 x0 x0;
    x0 x0+lx x0+lx x0 x0;
    x0 x0+lx x0+lx x0 x0;
    x0 x0+lx x0+lx x0 x0;
    x0+lx x0+lx x0+lx x0+lx x0+lx];
y=[y0 y0 y0 y0 y0;
    y0 y0 y0+ly y0+ly y0;
    y0 y0 y0+ly y0+ly y0;
    y0 y0 y0+ly y0+ly y0;
    y0+ly y0+ly y0+ly y0+ly y0+ly;
    y0 y0 y0+ly y0+ly y0];
z=[z0 z0 z0+lz z0+lz z0;
    z0 z0+lz z0+lz z0 z0;
    z0+lz z0+lz z0+lz z0+lz z0+lz;
    z0 z0 z0 z0 z0;
    z0 z0 z0+lz z0+lz z0;
    z0 z0+lz z0+lz z0 z0];
% plot3(1000,1000,1000)
% hold on
% plot3(0,0,0)
%plot3(x,y,z)
hold on;
for i=1:6
    h=fill3(x(i,:),y(i,:),z(i,:),k);
    set(h,'edgealpha',0,'facealpha',0.3)
end
%set(h,'edgealpha',0,'facealpha',0.6);
hold off;

