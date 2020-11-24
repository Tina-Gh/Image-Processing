function im2 = rotateImage( im, theta )
%ROTATEIMAGE  Rotates image about its centre
%
% im2 = rotateImage( im, theta) where im is the
%   image to be rotated and theta is the rotation
%   angle in degrees. Uses nearest neighbour
%   interpolation.
%
% Hanif M. Ladak, 2020

% Get image info, including centre
[rows, cols] = size( im );
ic = round( rows / 2); % i coord of centre
jc = round( cols / 2); % j coord of centre

% Convert theta to radians
theta = theta * pi / 180;

% Create output image: same size and type as input
im2 = uint8(zeros(size(im)));
for ip = 0 : rows-1, % NOTE: origin is (0,0)
  for jp = 0 : cols-1,
   
   % Find source (i, j) coordinates. Add 1 to
   % i and j since indexing starts at (1,1),
   % not (0,0).
   j = (jp-jc)*cos(theta) + (ip-ic)*sin(theta) + jc + 1;
   i = (jc-jp)*sin(theta) + (ip-ic)*cos(theta) + ic + 1;
   
   % Find gray-level value at im(i+1, j+1),
   % i,j may be non-integers
   im2(ip + 1, jp + 1) = nearest(im, i, j);
  end
end