%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 初始化:1)将起点加入到open表中
%        2)将起点从open表中弹出，并将待扩展点赋值为起点
% while：open表为空或者当前待扩展点为起点
%       1)if 找到了目标点
%           break;
%       2)对待扩展点扩展
%       3)如果待扩展节点的f(n)值小于等于open表中相应点的f(n)，则更新其父节点、f(n),g(n)，h(n)
%       4)将待扩展节点插入open表
%       5）找到当前open表中f(n)最低的节点的位置
%       6）if open表位空，输出no path break；
%       else a.更新待扩展节点 和从起始走到当前的path cost 
%           b.将待扩展节点动open表中删除
%           c.加入到close表
%           
%  完结后 回溯
%  close表最后为目标点
%  从目标点开始，找到它的父节点依次类推，直到找到起始节点
%        

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%