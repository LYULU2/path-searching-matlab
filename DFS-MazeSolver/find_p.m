%find the index of a given row & col
function index=find_p(nodes,num,a,b)
     for i=1:num
         if (nodes(i,2)==a)&&(nodes(i,3)==b)
              index=i;
         end
     end
end 