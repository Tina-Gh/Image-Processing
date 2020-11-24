function [theta, s, di, dj] = register( fnameS, fnameT )
%REGISTER  Landmark-based registration of two images. Takes into
%          account translation, rotation and scaling only.
%
% [theta, s, di, dj] = register( fnameS, fnameT ) where fnameS
%   is a string containing the filename of the SOURCE image, fnameT
%   is the filename of the TARGET image, theta is the estimated
%   rotation (measured CLOCKWISE from the j axis), s is the estimated
%   scaing factor (same in both the i and j directions, & di and dj are
%   translation components along the i- and j-axes.
%
%  Hanif M. Ladak, October 2020

% Read in images and display side-by-side; get landmarks
source = imread( fnameS );
target = imread( fnameT );
subplot( 221 )
imshow( source )
title( 'Source image', 'fontweight', 'bold', 'fontsize', 15 )
disp('Select landmarks in source image. Press ENTER key when done.');
[js, is] = ginput;
hold on; hp = plot(js, is, 'y+'); hold off
subplot( 222 )
imshow( target )
title( 'Target image', 'fontweight', 'bold', 'fontsize', 15 )
disp('Select landmarks in target image. Press ENTER key when done.');
[jt, it] = ginput;
hold on; hp = plot(jt, it, 'y+'); hold off

% Set up the matrix B and the vector k
N = length( js );
Sj = sum(js);
Si = sum(is);
Sjj = sum(js.*js);
Sii = sum(is.*is);
Siip = sum(is.*it);
Sjjp = sum(js.*jt);
Sjip = sum(js.*it);
Sjpi = sum(jt.*is);
Sjp = sum(jt);
Sip = sum(it);
B = [Sjj + Sii, 0, Sj, Si;...
    0, Sjj + Sii, -Si, Sj;...
    Sj, -Si, N, 0;...
    Si, Sj, 0, N];
k = [Sjjp + Siip, Sjip - Sjpi, Sjp, Sip]';
% Solve least-squares problem: [B]{a} = {k} using
% the \ operator, i.e., {a} = [B]\{k}
a = B\k;
theta = atan2( a(2), a(1) );
s = sqrt(a(1)^2 + a(2)^2);
dj = a(3);
di = a(4);