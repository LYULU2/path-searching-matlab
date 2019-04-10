% Function to Populate QUEUE: generates a new node for QUEUE
% Copyright 2009-2010 The MathWorks, Inc.

function new_row = insert(row_r,col_c, row_p, col_p, gn, hn, fn)
    new_row = [1, 8];
    new_row(1, 1) = 1;
    new_row(1, 2) = row_r;
    new_row(1, 3) = col_c;
    new_row(1, 4) = row_p;
    new_row(1, 5) = col_p;
    new_row(1, 6) = gn;
    new_row(1, 7) = hn;
    new_row(1, 8) = fn;
end