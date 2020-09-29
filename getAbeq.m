function [Aeq beq]= getAbeq(n_seg, n_order, waypoints, ts, start_cond, end_cond)
    n_all_poly = n_seg*(n_order+1);
    %#####################################################
    % p,v,a,j constraint in start, 
    Aeq_start = zeros(4, n_all_poly);
    beq_start = zeros(4, 1);
    % STEP 2.1: write expression of Aeq_start and beq_start
    for k=0:3
        for i= 0:n_order
            if i>=k
                Aeq_start(k+1,i+1)=(factorial(i)/factorial(i-k))*(0^(i-k));
            end
        end
    end        
    beq_start(:,1) = start_cond;
    %#####################################################
    % p,v,a,j constraint in end
    Aeq_end = zeros(4, n_all_poly);
    beq_end = zeros(4, 1);
    % STEP 2.2: write expression of Aeq_end and beq_end
    for k=0:3
        for i= 0:n_order
           if i>=k
                Aeq_end(k+1,(n_seg-1)*(n_order+1)+i+1)=(factorial(i)/factorial(i-k))*(ts(n_seg)^(i-k));
           end
        end
    end        
    beq_end(:,1)= end_cond;
    
    %#####################################################
    % position constrain in all middle waypoints
    Aeq_wp = zeros(n_seg-1, n_all_poly);
    beq_wp = zeros(n_seg-1, 1);
    % STEP 2.3: write expression of Aeq_wp and beq_wp
    for wp=1:n_seg-1
        for i= 0:n_order
           if i>=0
%                 Aeq_wp(wp,wp*(n_order+1)+i+1)=(factorial(i)/factorial(i-0))*(0^(i-0));
                Aeq_wp(wp,(wp-1)*(n_order+1)+i+1)=(factorial(i)/factorial(i-0))*(ts(wp)^(i-0));
           end
        end
    end  
    for j=1:n_seg-1
        beq_wp(j,1) = waypoints(j+1);
    end
    
    %#####################################################
    % position continuity constrain between each 2 segments
    Aeq_con_p = zeros(n_seg-1, n_all_poly);
    beq_con_p = zeros(n_seg-1, 1);
    % STEP 2.4: write expression of Aeq_con_p and beq_con_p
    for kp=1:n_seg-1

        for i= 0:n_order
            if i>=0
                Aeq_con_p(kp,(kp-1)*(n_order+1)+i+1) =(factorial(i)/factorial(i-0))*(ts(kp)^(i-0));
            end
        end
         
        for l= 0:n_order
            if l>=0
                Aeq_con_p(kp,kp*(n_order+1)+l+1) =-(factorial(l)/factorial(l-0))*(0^(l-0));
            end
        end      
    end        
 
    
    %#####################################################
    % velocity continuity constrain between each 2 segments
    Aeq_con_v = zeros(n_seg-1, n_all_poly);
    beq_con_v = zeros(n_seg-1, 1);
    % STEP 2.5: write expression of Aeq_con_v and beq_con_v
    for kp=1:n_seg-1
        for i= 0:n_order
            if i>=1
                Aeq_con_v(kp,(kp-1)*(n_order+1)+i+1) =(factorial(i)/factorial(i-1))*(ts(kp)^(i-1));
            end
        end
        for l= 0:n_order
            if l>=1
                Aeq_con_v(kp,kp*(n_order+1)+l+1) =-(factorial(l)/factorial(l-1))*(0^(l-1));
            end
        end      
    end          


    %#####################################################
    % acceleration continuity constrain between each 2 segments
    Aeq_con_a = zeros(n_seg-1, n_all_poly);
    beq_con_a = zeros(n_seg-1, 1);
    % STEP 2.6: write expression of Aeq_con_a and beq_con_a
    for kp=1:n_seg-1
        for i= 0:n_order
            if i>=2
                Aeq_con_a(kp,(kp-1)*(n_order+1)+i+1) =(factorial(i)/factorial(i-2))*(ts(kp)^(i-2));
            end
        end
        for l= 0:n_order
            if l>=2
                Aeq_con_a(kp,kp*(n_order+1)+l+1) =-(factorial(l)/factorial(l-2))*(0^(l-2));
            end
        end      
    end      
  
    
    %#####################################################
    % jerk continuity constrain between each 2 segments
    Aeq_con_j = zeros(n_seg-1, n_all_poly);
    beq_con_j = zeros(n_seg-1, 1);
    % STEP 2.7: write expression of Aeq_con_j and beq_con_j
    for kp=1:n_seg-1
        for i= 0:n_order
            if i>=3
                Aeq_con_j(kp,(kp-1)*(n_order+1)+i+1) =(factorial(i)/factorial(i-3))*(ts(kp)^(i-3));
            end
        end
        for l= 0:n_order
            if l>=3
                Aeq_con_j(kp,kp*(n_order+1)+l+1) =-(factorial(l)/factorial(l-3))*(0^(l-3));
            end
        end      
    end          
   
    
    %#####################################################
    % combine all components to form Aeq and beq   
    Aeq_con = [Aeq_con_p; Aeq_con_v; Aeq_con_a; Aeq_con_j];
    beq_con = [beq_con_p; beq_con_v; beq_con_a; beq_con_j];
    Aeq = [Aeq_start; Aeq_end; Aeq_wp; Aeq_con];
    beq = [beq_start; beq_end; beq_wp; beq_con];
    
end