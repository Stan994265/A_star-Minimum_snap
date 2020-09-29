%clc;clear;close all;
%path = ginput()*100 ;

n_order       = 7;% order of poly
n_seg         = size(path,1)-1;% segment number
n_poly_perseg = (n_order+1); % coef number of perseg

ts = zeros(n_seg, 1);
% calculate time distribution in proportion to distance between 2 points
dist     = zeros(n_seg, 1);
dist_sum = 0;
T        = 25.0;
t_sum    = 0;

for i = 1:n_seg
    dist(i) = sqrt((path(i+1, 1)-path(i, 1))^2 + (path(i+1, 2) - path(i, 2))^2);
    dist_sum = dist_sum+dist(i);
end
for i = 1:n_seg-1
    ts(i) = dist(i)/dist_sum*T;
    t_sum = t_sum+ts(i);
end
ts(n_seg) = T - t_sum;

% or you can simply set all time distribution as 1
% for i = 1:n_seg
%     ts(i) = 1.0;
% end

poly_coef_x = MinimumSnapQPSolver(path(:,1), ts, n_seg, n_order);
poly_coef_y = MinimumSnapQPSolver(path(:,2), ts, n_seg, n_order);

% display the trajectory
X_n = [];
Y_n = [];
count = 0;
tstep = 0.01;
Time=[];
time=0;
Time(1)=0;
for i=0:n_seg-1
    %#####################################################
    % STEP 3: get the coefficients of i-th segment of both x-axis
    % and y-axis
    Pxi =poly_coef_x(i*(n_order+1)+1:(i+1)*(n_order+1));
    Pyi =poly_coef_y(i*(n_order+1)+1:(i+1)*(n_order+1));
    %change into p7...p0
    Pxi =flipud(Pxi);
    Pyi =flipud(Pyi);

    for t = 0:tstep:ts(i+1)
        X_n(count+1)  = polyval(Pxi,t);
        Y_n(count+1)  = polyval(Pyi,t);
        VX_n(count+1) = get_vaj_poly(1,t)*Pxi;
        VY_n(count+1) = get_vaj_poly(1,t)*Pyi;
        AX_n(count+1) = get_vaj_poly(2,t)*Pxi;
        AY_n(count+1) = get_vaj_poly(2,t)*Pyi;
        JX_n(count+1) = get_vaj_poly(3,t)*Pxi;
        JY_n(count+1) = get_vaj_poly(3,t)*Pyi;
        count = count + 1;
        time=time+tstep;
        Time(count) = time;
        %count = count + 1;
    end
end
 

%k取1,2,3，对应v,a,j
function vaj_poly=get_vaj_poly(k,t_)
    vaj_poly = [];
    for i= 0:7
        if i>=k
           vaj_poly(1,i+1)=(factorial(i)/factorial(i-k))*(t_^(i-k));          
        end
    end
    vaj_poly=fliplr(vaj_poly);  %行矩阵用fliplr
end

function poly_coef = MinimumSnapQPSolver(waypoints, ts, n_seg, n_order)
    start_cond = [waypoints(1), 0, 0, 0];
    end_cond   = [waypoints(end), 0, 0, 0];
    %#####################################################
    % STEP 1: compute Q of p'Qp
    Q = getQ(n_seg, n_order, ts);
    %#####################################################
    % STEP 2: compute Aeq and beq 
    [Aeq, beq] = getAbeq(n_seg, n_order, waypoints, ts, start_cond, end_cond);
    f = zeros(size(Q,1),1);
    poly_coef = quadprog(Q,f,[],[],Aeq, beq);
end