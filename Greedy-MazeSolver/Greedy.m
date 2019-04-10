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
function []=Greedy(maze)
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
NoPath = 1; % assume there exists a path
path_cost = 0; % cost g(n): start node to the current node n
goal_distance = distance(Node, Target); % cost h(n): heuristic cost of n
QUEUE(QUEUE_COUNT, :) = insert(Node.row, Node.col,Node.row, Node.col, path_cost, goal_distance, goal_distance);
QUEUE(QUEUE_COUNT, 1) = 0; 

%% Start the search
while(not_same_node(Node,Target) && NoPath == 1)
    
    % expand the current node to obtain child nodes
    exp = expand_maze(Node, path_cost,Target, maze);
    exp_count  = size(exp, 1); 
    % Update exp QUEUE with child nodes; exp: [node, g(n), h(n), f(n)]
    
    %insert new nodes in QUEUE
    for i = 1 : exp_count
        flag = 0;
        for j = 1 : QUEUE_COUNT
            %if same node in queue and nodes in list,find which have min
            %path cost
            if(exp(i,1)==QUEUE(j,2)&&exp(i,2)==QUEUE(j,3))
                %update the min fn
                QUEUE(j, 8) = min(QUEUE(j, 8), exp(i, 5));
                if QUEUE(j, 8) == exp(i, 5)
                    % update parents, g(n) and h(n)
                    QUEUE(j, 4) = Node.row; % the parent node
                    QUEUE(j, 5) = Node.col;
                    QUEUE(j, 6) = exp(i, 3);
                    QUEUE(j, 7) = exp(i, 4);
                end % end of minimum f(n) check
                flag = 1;
            end
        end
        if flag == 0
            % a new node explored
            QUEUE_COUNT = QUEUE_COUNT + 1;
            QUEUE(QUEUE_COUNT, :) = insert(exp(i, 1), exp(i, 2), Node.row, Node.col, exp(i, 3), exp(i, 4),exp(i,5));
        end
    end

    % A*: find the node in QUEUE with the smallest f(n), returned by min_fn
    index_min_node = min_hn(QUEUE, QUEUE_COUNT);
    if (index_min_node ~= -1)
        % set current node (xNode, yNode) to the node with minimum f(n)
        Node = point(QUEUE(index_min_node, 2),QUEUE(index_min_node, 3));
        path_cost = QUEUE(index_min_node, 6); % cost g(n)
        %set the value to 6 if processed
        maze=setMazePosition(maze,Node,6);
        QUEUE(index_min_node, 1) = 0;%mark this point as processed
    else
        NoPath = 0; % there is no path!
    end
    dispMaze(maze);
end


%% Output / plot your route
if NoPath==1
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

if NoPath==1
    fprintf('Completed successfully\n');
else
    fprintf('There is no available path\n');
end

end