%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A* ALGORITHM Demo
% 04-26-2005    Copyright 2009-2010 The MathWorks, Inc.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Matlab Basics
%{
    % "MATLAB Overview" @ MathWorks
    % "Writing a Matlab Program" @ MathWorks
    % Choose your working folder, where all Astar files are saved
    % Understand step-by-step the source code, and start working on Coursework 1
%}
function []=DFS(maze)
%% define the problem via GUI
%find the target point and the end point
%path= [];
maze_size = size(maze, 1);
Start=point(maze_size,2);
for i= 2 : maze_size-1
    if(maze(end,i)==3)
        Start.col=i;
    end
end
Target=point(1,2);
for i= 2 : maze_size-1
    if(maze(1,i)==4)
        Target.col=i;
    end
end
Target.row=Target.row+1;
%% add the starting node as the first node (root node) in QUEUE
% QUEUE: [0/1, node, Parent, g(n),h(n), f(n)]
Node=adjust(Start, -1, 0); %the first node
maze=setMazePosition(maze,Node,6);
QUEUE = [];
QUEUE_COUNT = 1;
no_path = 1; % assume there exists a path
path_cost = 0; % cost g(n): start node to the current node n
goal_distance = distance(Node, Target); % cost h(n): heuristic cost of n
QUEUE(QUEUE_COUNT, :) = insert(Node.row, Node.col,Node.row, Node.col, path_cost, goal_distance, goal_distance);
QUEUE(QUEUE_COUNT, 1) = 0;


%% Start the search
while(not_same_node(Node,Target) &&no_path~=0)
    % while not reaching the end or not finished searching
    % expand the current node to obtain child nodes
    exp = expand_maze(Node, path_cost,Target, maze);
    exp_count  = size(exp, 1); 
    flag_q=0;
    %insert new nodes in QUEUE
    for i = 1 : exp_count
        for j = 1 : QUEUE_COUNT
            %if same node in queue and nodes in list,ignored
            if(exp(i,1)~=QUEUE(j,2)||exp(i,2)~=QUEUE(j,3))
                flag_q=1;
            end
        end
        if flag_q==1
            % a new node explored
            QUEUE_COUNT = QUEUE_COUNT + 1;
            QUEUE(QUEUE_COUNT, :) = insert(exp(i, 1), exp(i, 2), Node.row, Node.col, exp(i, 3), exp(i, 4),exp(i,5));
        end
        flag_q=0;
    end
    
    index_next_node = find_child(QUEUE, QUEUE_COUNT,Node);
    if (index_next_node ~= -1)
        Node.row=QUEUE(index_next_node,2);
        Node.col=QUEUE(index_next_node,3);
        %set the value to 6 if processed
        maze=setMazePosition(maze,Node,6);
        QUEUE(index_next_node, 1) = 0;
        path_cost=QUEUE(index_next_node,6);
    else
        % this node cannot be expanded, return to the parent
        index_p=find_p(QUEUE,QUEUE_COUNT,Node.row,Node.col);
        Node.row=QUEUE(index_p,4);
        Node.col=QUEUE(index_p,5);
    end
    if (~not_same_node(Node,Start))&& find_child(QUEUE,QUEUE_COUNT,Node)==-1
        no_path=0;
    end    
    dispMaze(maze);
end

%% Output / plot your route
if no_path==1
    Start.row=Start.row-1;
    num=QUEUE_COUNT;
    while not_same_node(Node,Start)
         maze=setMazePosition(maze, Node, 5); %paint path balck as 5
         index=find_p(QUEUE,num,Node.row,Node.col);
         Node.row=QUEUE(index,4);
         Node.col=QUEUE(index,5);
         dispMaze(maze);
         num=index;
    end
    maze=setMazePosition(maze, Node, 5);
    dispMaze(maze);
end

if no_path==1
    fprintf('Completed successfully\n');
else
    fprintf('There is no available path\n');
end

end