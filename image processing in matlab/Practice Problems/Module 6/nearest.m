function gl = nearest( im, i, j )
%NEAREST   Nearest neighbour gray-level interpolation

i = round(i);
j = round(j);

% Make sure computed (i, j) are within bounds
if ~((j < 1) | (j > size(im, 2)) | (i < 1) | (i > size(im, 1))),
   % Within bounds
   gl = im(i, j);
else
   % Out of bounds
   gl = 0;
end