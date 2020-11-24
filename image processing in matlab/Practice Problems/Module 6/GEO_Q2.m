% Commands typed at MATLAB prompt for Question 2

% Read in and display original image
im=imread('pout.tif');
subplot(221)
imshow(im)
title('Original', 'fontsize', 12, 'fontweight', 'bold')

% Part (a) Translations
trans = [1 0 0; 0 1 0; 20 -17 1];
tform_trans = maketform('affine', trans);
im_a= imtransform(im, tform_trans, 'xdata', [1 size(im, 2)], 'ydata', [1 size(im,1)]);
subplot(222), imshow(im_a), title('Trans.', 'fontsize', 12, 'fontweight', 'bold')
% Note: xdata and ydata specify origin and max columns and rows

% Part (b) Rotation
theta = 30*pi/180; % Converting from degrees to radians
rot = [cos(theta), sin(theta), 0; -sin(theta), cos(theta), 0; 0, 0, 1];
tform_rot = maketform('affine', rot);
im_b= imtransform(im, tform_rot, 'xdata', [1 size(im, 2)], 'ydata', [1 size(im,1)]);
subplot(223), imshow(im_b), title('Rot.', 'fontsize', 12, 'fontweight', 'bold')
% Note: If we wish to retain all of the data in the original image, we
% would use:
% im_b= imtransform(im, tform_rot);
% The resulting image will be larger with some blank (black) areas.

% Part (c) Scaling
scale = [0.5, 0, 0; 0, 0.8, 0; 0, 0, 1];
tform_scale = maketform('affine', scale);
im_c= imtransform(im, tform_scale, 'xdata', [1 size(im, 2)], 'ydata', [1 size(im,1)]);
subplot(224), imshow(im_c), title('Scale', 'fontsize', 12, 'fontweight', 'bold')
% NOTE: If you type th following isntead:
% im_c= imtransform(im, tform_scale);
% You should note that the image matrix itself changes size.