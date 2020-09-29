function exp_array=expand_array(node_x,node_y,gn,xTarget,yTarget,MAP,MAX_X,MAX_Y)
    %Function to return an expanded array
    %This function takes a node and returns the expanded list
    %of successors,with the calculated fn values.
    %The criteria being none of the successors are on the CLOSED list.
    %
    %Copyright 2009-2010 The MathWorks, Inc.
    
    %EXPANDED ARRAY FORMAT
    %--------------------------------
    %|X val |Y val ||h(n) |g(n)|f(n)|
    %--------------------------------

    %  -1 1  | 0 1  | 1 1
    %  _____ | ____ |_____
    %  -1 0  | 0 0  | 1 0
    %  _____ | ____ |_____
    %  -1 -1 | 0 -1 | 1 -1    
    exp_array=[];
    
    sx1=node_x-1;
    sy1=node_y+1;    
    sx2=node_x;
    sy2=node_y+1;    
    sx3=node_x+1;
    sy3=node_y+1;  
    sx4=node_x+1;
    sy4=node_y;
    sx5=node_x+1;
    sy5=node_y-1;
    sx6=node_x;
    sy6=node_y-1;
    sx7=node_x-1;
    sy7=node_y-1;
    sx8=node_x-1;
    sy8=node_y;
    
    
    exp_count=1;
    if (MAP(sx1,sy1)~=-1) 
        if(MAP(sx2,sy2)~=-1 || MAP(sx8,sy8)~=-1)
            exp_array(exp_count,1) = sx1;
            exp_array(exp_count,2) = sy1;
            exp_array(exp_count,3) = distance(xTarget,yTarget,sx1,sy1);%distance between node and goal,hn
            exp_array(exp_count,4) = gn+distance(node_x,node_y,sx1,sy1);%cost of travelling to node��gn
            exp_array(exp_count,5) = exp_array(exp_count,3)+exp_array(exp_count,4);%fn
            exp_count=exp_count+1;
        end
    end
    if (MAP(sx2,sy2)~=-1)         
            exp_array(exp_count,1) = sx2;
            exp_array(exp_count,2) = sy2;
            exp_array(exp_count,3) = distance(xTarget,yTarget,sx2,sy2);%distance between node and goal,hn
            exp_array(exp_count,4) = gn+distance(node_x,node_y,sx2,sy2);%cost of travelling to node��gn
            exp_array(exp_count,5) = exp_array(exp_count,3)+exp_array(exp_count,4);%fn
            exp_count=exp_count+1;
    end
    if (MAP(sx3,sy3)~=-1) 
        if(MAP(sx2,sy2)~=-1 || MAP(sx4,sy4)~=-1)
            exp_array(exp_count,1) = sx3;
            exp_array(exp_count,2) = sy3;
            exp_array(exp_count,3) = distance(xTarget,yTarget,sx3,sy3);%distance between node and goal,hn
            exp_array(exp_count,4) = gn+distance(node_x,node_y,sx3,sy3);%cost of travelling to node��gn
            exp_array(exp_count,5) = exp_array(exp_count,3)+exp_array(exp_count,4);%fn
            exp_count=exp_count+1;
        end
    end
    if (MAP(sx4,sy4)~=-1)         
            exp_array(exp_count,1) = sx4;
            exp_array(exp_count,2) = sy4;
            exp_array(exp_count,3) = distance(xTarget,yTarget,sx4,sy4);%distance between node and goal,hn
            exp_array(exp_count,4) = gn+distance(node_x,node_y,sx4,sy4);%cost of travelling to node��gn
            exp_array(exp_count,5) = exp_array(exp_count,3)+exp_array(exp_count,4);%fn
            exp_count=exp_count+1;        
    end
    if (MAP(sx5,sy5)~=-1) 
        if(MAP(sx4,sy4)~=-1 || MAP(sx6,sy6)~=-1)
            exp_array(exp_count,1) = sx5;
            exp_array(exp_count,2) = sy5;
            exp_array(exp_count,3) = distance(xTarget,yTarget,sx5,sy5);%distance between node and goal,hn
            exp_array(exp_count,4) = gn+distance(node_x,node_y,sx5,sy5);%cost of travelling to node��gn
            exp_array(exp_count,5) = exp_array(exp_count,3)+exp_array(exp_count,4);%fn
            exp_count=exp_count+1;
        end
    end
    if (MAP(sx6,sy6)~=-1) 
            exp_array(exp_count,1) = sx6;
            exp_array(exp_count,2) = sy6;
            exp_array(exp_count,3) = distance(xTarget,yTarget,sx6,sy6);%distance between node and goal,hn
            exp_array(exp_count,4) = gn+distance(node_x,node_y,sx6,sy6);%cost of travelling to node��gn
            exp_array(exp_count,5) = exp_array(exp_count,3)+exp_array(exp_count,4);%fn
            exp_count=exp_count+1;
    end
    if (MAP(sx7,sy7)~=-1) 
        if(MAP(sx6,sy6)~=-1 || MAP(sx8,sy8)~=-1)
            exp_array(exp_count,1) = sx7;
            exp_array(exp_count,2) = sy7;
            exp_array(exp_count,3) = distance(xTarget,yTarget,sx7,sy7);%distance between node and goal,hn
            exp_array(exp_count,4) = gn+distance(node_x,node_y,sx7,sy7);%cost of travelling to node��gn
            exp_array(exp_count,5) = exp_array(exp_count,3)+exp_array(exp_count,4);%fn
            exp_count=exp_count+1;
        end
    end
    if (MAP(sx8,sy8)~=-1) 
            exp_array(exp_count,1) = sx8;
            exp_array(exp_count,2) = sy8;
            exp_array(exp_count,3) = distance(xTarget,yTarget,sx8,sy8);%distance between node and goal,hn
            exp_array(exp_count,4) = gn+distance(node_x,node_y,sx8,sy8);%cost of travelling to node��gn
            exp_array(exp_count,5) = exp_array(exp_count,3)+exp_array(exp_count,4);%fn
            exp_count=exp_count+1;
    end
    
    
    
    
    
    
    
    
    
    
    
    
%     
%     for k= 1:-1:-1
%         for j= 1:-1:-1
%             if ( k~=j || k~=0)  %The node itself is not its successor k~=j || k~=0
%                 s_x = node_x+k;
%                 s_y = node_y+j;
%                 if( (s_x >0 && s_x <=MAX_X) && (s_y >0 && s_y <=MAX_Y))%node within array bound
%                    flag=1;                     
% 
%                     if (MAP(s_x,s_y)==-1)
%                        flag=0; 
%                        continue
%                     end
%                     if(k==-1&&j==1)
%                         if ((s_x-1 >0 && s_x-1 <=MAX_X) && (s_y+1 >0 && s_y+1 <=MAX_Y)) 
%                             if(MAP(s_x,s_y+1)==-1 && MAP(s_x-1,s_y)==-1)
%                             	flag=0;
%                                 continue
%                             end
%                         end
%                     end                                     
%                     if( k==1&&j==1)
%                         if ((s_x+1 >0 && s_x+1 <=MAX_X) && (s_y+1 >0 && s_y+1 <=MAX_Y) )
%                             if(MAP(s_x,s_y+1)==-1 && MAP(s_x+1,s_y)==-1)
%                                 flag=0;
%                                 continue
%                             end
%                         end
%                     end
%                     if( k==1&&j==-1)
%                         if ((s_x+1 >0 && s_x+1 <=MAX_X) && (s_y-1 >0 && s_y-1 <=MAX_Y) )
%                             if(MAP(s_x+1,s_y)==-1 && MAP(s_x,s_y-1)==-1)
%                             
%                                 flag=0;
%                                 continue
%                             end
%                         end
%                     end
%                     if( k==-1&&j==-1)
%                         if ((s_x-1 >0 && s_x-1 <=MAX_X) && (s_y-1 >0 && s_y-1 <=MAX_Y) )
%                             if(MAP(s_x-1,s_y)==-1 && MAP(s_x,s_y-1)==-1)
%                                 flag=0;
%                                 continue
%                             end
%                         end  
%                     end
%                 end
%             end
%             if (flag == 1)
%                 exp_array(exp_count,1) = s_x;
%                 exp_array(exp_count,2) = s_y;
%                 exp_array(exp_count,3) = distance(xTarget,yTarget,s_x,s_y);%distance between node and goal,hn
%                 exp_array(exp_count,4) = gn+distance(node_x,node_y,s_x,s_y);%cost of travelling to node��gn
%                 exp_array(exp_count,5) = exp_array(exp_count,3)+exp_array(exp_count,4);%fn
%                 exp_count=exp_count+1;
%             end
% %                     if (flag == 1)
% %                         exp_array(exp_count,1) = s_x;
% %                         exp_array(exp_count,2) = s_y;
% %                         exp_array(exp_count,3) = distance(xTarget,yTarget,s_x,s_y);%distance between node and goal,hn
% %                         exp_array(exp_count,4) = gn+distance(node_x,node_y,s_x,s_y);%cost of travelling to node��gn
% %                         exp_array(exp_count,5) = exp_array(exp_count,3)+exp_array(exp_count,4);%fn
% %                         exp_count=exp_count+1;
% %                     end%Populate the exp_array list!!!
%                    
%                 %end% End of node within array bound
%            %End of if node is not its own successor loop
%         end%End of j for loop
%     end%End of k for loop    