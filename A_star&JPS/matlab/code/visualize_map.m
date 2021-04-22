function visualize_map(map,path)
%This function visualizes the 2D grid map 
%consist of obstacles/start point/target point/optimal path.

    % obstacles
    for obs_cnt = 2: size(map, 1) - 1
        scatter(map(obs_cnt, 1)-0.5,map(obs_cnt, 2)-0.5,200,155,'filled');%位置x,y 大小 颜色，填满
       % 英文注释 scatter(x,y,sz,c) specifies the circle colors. To plot all circles with the same color, specify c as a color name or an RGB triplet. 
       %To use varying color, specify c as a vector or a three-column matrix of RGB triplets.
        hold on;
        grid on;
        %grid minor;
        axis equal;        
        axis ([0 10 0 10 ]);
        hold on;
    end
    % start point
    scatter(map(1, 1)-0.5, map(1, 2)-0.5,'b','*');
    hold on;
    % target point
	scatter(map(size(map, 1), 1)-0.5, map(size(map, 1), 2)-0.5, 'r','*');
    hold on;
    %optimal path
    for path_cnt = 2:size(path,1)
        scatter(path(path_cnt,1)-0.5,path(path_cnt,2)-0.5,'b');
        hold on;
    end

end
