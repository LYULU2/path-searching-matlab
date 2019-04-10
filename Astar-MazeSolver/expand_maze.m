%exp_array=[position,cost g(n),cost h(n), sum f(n)]

function exp_array = expand_maze(node, gn, Target, maze)
    exp_array=[];
    exp_count=1;
    for k = 1 : -1 : -1 % explore surrounding locations
        for j = 1 : -1 : -1
            if (k ~= j && k ~=-j)  % the node itself is not its successor
                s = adjust(node, k, j);
                if(mazeValue(maze,s,0,0)==1)
                    exp_array(exp_count, 1) = s.row;
                    exp_array(exp_count, 2) = s.col;
                    exp_array(exp_count, 3) = gn + distance(node, s); % cost g(n)
                    exp_array(exp_count, 4) = distance(Target, s); % cost h(n)
                    exp_array(exp_count, 5) = exp_array(exp_count, 3) + exp_array(exp_count, 4); % f(n)
                    exp_count = exp_count + 1;
                end
            end
        end
    end
end