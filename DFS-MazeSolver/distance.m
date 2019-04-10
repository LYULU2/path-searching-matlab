% This function calculates the distance between any two cartesian coordinates.
% Copyright 2009-2010 The MathWorks, Inc.

function dist = distance(start_p, end_p)
dist = sqrt((start_p.row - end_p.row)^2 + (start_p.col - end_p.col)^2); % h1
