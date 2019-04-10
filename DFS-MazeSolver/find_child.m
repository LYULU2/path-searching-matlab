% Function to return the index of the node with minimum f(n) in QUEUE
% Copyright 2009-2010 The MathWorks, Inc.
%return -1 if there is no path or the index in the exp array
function i_next = find_child(QUEUE, QUEUE_COUNT,node)
flag=0;
 for j = 1 : QUEUE_COUNT
     if (QUEUE(j, 1) == 1 && QUEUE(j,4)== node.row && QUEUE(j,5)==node.col)
         i_next=j;
         flag=1;
         break;%find the first child node
     end
 end 
 
 if flag==0
     i_next=-1;%this node has no child
 end