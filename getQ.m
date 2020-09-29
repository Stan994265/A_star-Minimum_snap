function Q = getQ(n_seg, n_order, ts)
    
    Q = zeros(8*n_seg,8*n_seg);
    Q_k = zeros(8*n_seg,8*n_seg);
    for k = 1:n_seg       
        %#####################################################
        % STEP 1.1: calculate Q_k of the k-th segment 
        for i= 4:n_order
            for l=4:n_order
                Q_k(8*(k-1)+l+1,8*(k-1)+i+1)=i*(i-1)*(i-2)*(i-3)*l*(l-1)*(l-2)*(l-3)/(i+l-7)*(ts(k)^(i+l-7));
            end
        end        
    end
    Q = Q_k;
end
