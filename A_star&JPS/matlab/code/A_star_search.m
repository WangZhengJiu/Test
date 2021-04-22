function path= A_star_search(map,MAX_X,MAX_Y)
%%
%map�����һ��Ϊgoal�ĺ������꣬��һ��Ϊ������꣬������Ϊ�����ϰ��������
%This part is about map/obstacle/and other settings
    %pre-process the grid map, add offset
    size_map = size(map,1); %��������
    Y_offset = 0;
    X_offset = 0;
    
    %Define the 2D grid map array.
    %Obstacle=-1, Target = 0, Start=1  
    MAP=2*(ones(MAX_X,MAX_Y));%��ͨ·��Ϊ2
    
    %Initialize MAP with location of the target    �����յ�
    xval=floor(map(size_map, 1)) + X_offset;%floor����ȡ��
    yval=floor(map(size_map, 2)) + Y_offset;
    xTarget=xval;
    yTarget=yval;
    MAP(xval,yval)=0;%set goal
    
    %Initialize MAP with location of the obstacle �����ϰ���
    for i = 2: size_map-1
        xval=floor(map(i, 1)) + X_offset;
        yval=floor(map(i, 2)) + Y_offset;
        MAP(xval,yval)=-1;
    end 
    
    %Initialize MAP with location of the start point  �������
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

    %Put all obstacles on the Closed list   ���ϰ�����뵽closed����ȥ
    k=1;%Dummy counter   ������
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
    xNode=xval;   %���������xval yval�ĸ�ֵΪ���λ��
    yNode=yval;
    OPEN_COUNT=1; %open�����
    goal_distance=distance(xNode,yNode,xTarget,yTarget);   %���㵱ǰ��λ�ú��յ����
    path_cost=0;
    OPEN(OPEN_COUNT,:)=insert_open(xNode,yNode,xNode,yNode,goal_distance,path_cost,goal_distance);  %�������
     %--------------------------------------------------------------------------
    %IS ON LIST 1/0 |X val �ڵ�xֵ |Y val �ڵ�yֵ |Parent X val |Parent Y val |h(n)����ʽ��Ϣֵ �������յ����|g(n)������ߵ���ǰ���·������|f(n)=h(n)+g(n)|
    %--------------------------------------------------------------------------
    OPEN(OPEN_COUNT,1)=0;                   %��չ��Ϻ󣬴�open���е������
    CLOSED_COUNT=CLOSED_COUNT+1;            %��������close��
    CLOSED(CLOSED_COUNT,1)=xNode;
    CLOSED(CLOSED_COUNT,2)=yNode;
    NoPath=1;

%%
%This part is your homework
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% START ALGORITHM
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   
while(ismember(1,OPEN(:,1))||OPEN_COUNT==1) %��OPEN��ǿ���ѭ��   ismember�ж�1�Ƿ���OPEN(:,1)�е���
    
    if(xNode==xTarget && yNode==yTarget)     %���xNode��yNode��Ŀ��ڵ��˳�
            break;
    end
        exp_array=expand_array(xNode,yNode,path_cost,xTarget,yTarget,CLOSED,MAX_X,MAX_Y); %expand
        
         for i=1:size(exp_array,1)  %i=1:����չ��ĸ���
             for j=1:OPEN_COUNT
                 if(exp_array(i,1)==OPEN(j,2)&&exp_array(i,2)==OPEN(j,3))
                     OPEN(j,end)=min(OPEN(j,end),exp_array(i,end));%������չ���f(n)ֵС�ڵ���open���е�f(n)ֵ��
                                                                   %�����open���е�f(n)��h(n),g(n)���丸�׽ڵ�
                      if OPEN(j,end)== exp_array(i,end)
                         OPEN(j,4)=xNode;
                         OPEN(j,5)=yNode;
                         OPEN(j,6)=exp_array(i,3);
                         OPEN(j,7)=exp_array(i,4);
                      end
                 end
                  
                
             end  
             OPEN_COUNT=OPEN_COUNT+1;
             OPEN(OPEN_COUNT,:)=insert_open(exp_array(i,1),exp_array(i,2),...
             xNode,yNode,exp_array(i,3),exp_array(i,4),exp_array(i,5)); %Ϊopen���µ�һ�и�ֵ
         end
       
       row_index_of_min=min_fn(OPEN,OPEN_COUNT,xTarget,yTarget);         %find the point with lowest fn
       if(row_index_of_min==-1)  %there is no path
           error("ERROR:OPENLIST is empty.There is no path!!!");
           break
       else
           xNode=OPEN(row_index_of_min,2);
           yNode=OPEN(row_index_of_min,3);
           path_cost=OPEN(row_index_of_min,6);
           OPEN(row_index_of_min,1)=0;     %�� OPENLIST��ɾ��
           
        CLOSED(CLOSED_COUNT,1)=xNode;
        CLOSED(CLOSED_COUNT,2)=yNode;
        CLOSED_COUNT=CLOSED_COUNT+1;
       end
     %
     %finish the while loop
     %
     
    end %End of While Loop
    
    %Once algorithm has run The optimal path is generated by starting of at the
    %last node(if it is the target node) and then identifying its parent node
    %until it reaches the start node.This is the optimal path
    
    %
    %How to get the optimal path after A_star search?
    %please finish it
    %
    
    %����
   path = [];%��
   path(1,1)=CLOSED(end,1);%��Ŀ��㿪ʼ
   path(1,2)=CLOSED(end,2);
   xval=path(1,1);
   yval=path(1,2);
   if(xval==xTarget&&yval==yTarget)
       count=2;
       x_parent_node=OPEN(node_index(OPEN,xval,yval),4);%�ҵ�Ŀ���ĸ��ڵ�
       y_parent_node=OPEN(node_index(OPEN,xval,yval),5);
       while(1)
           if(x_parent_node==xStart&&y_parent_node==yStart)
               break
           end
           path(count,1)=x_parent_node;
           path(count,2)=y_parent_node;
           index_parent_node=node_index(OPEN,x_parent_node,y_parent_node);
           x_parent_node=OPEN(index_parent_node,4);
           y_parent_node=OPEN(index_parent_node,5);
           count=count+1;
       end
   else
       path=[];
       error("ERROR:There is no path!!!");
   end
   end
