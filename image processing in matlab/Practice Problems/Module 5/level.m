function [im2, a] = level(fname)
%level function removes the background (leveling).
%
%
    im = imread(fname); %Read in the image and display it.
    figure(1), imshow(im);
    
    disp('Select points using left mouse button. Press Enter key when done.');
    [x, y, I] = impixel; %x=5X1, y=5x1, I=5x3(because I considers R, G, B)
    I = I(:, 3); %because im is a gray level image (not RGB), then I(:, 1) = I(:, 2) = I(:, 3)
    hold on; plot(x, y, 'y+'); hold off; %Display the points
    
    
    N = length(x); %Fit data at selected points to the background function. (Regression)
    sx = sum(x); %First, compute elements needed in matrix [C]. (error or cost function)
    sy = sum(y);
    sxx = sum(x .* x);
    syy = sum(y .* y);
    sxy = sum(x .* y);
    sxxx = sum(x .^ 3);
    sxxy = sum(x .* x .* y);
    sxyy = sum(x .* y .* y);
    syyy = sum(y .^ 3);
    sxxxx = sum(x .^ 4);
    sxxxy = sum(y .* x .^ 3);
    sxxyy = sum(x .* x .* y .* y);
    sxyyy = sum(x .* y .^ 3);
    syyyy = sum(y .^ 4);
    C = [N, sx, sy, sxx, syy, sxy;
         sx, sxx, sxy, sxxx, sxyy, sxxy;
         sy, sxy, syy, sxxy, syyy, sxyy;
         sxx, sxxx, sxxy, sxxxx, sxxyy, sxxxy;
         syy, sxyy, syyy, sxxyy, syyyy, sxyyy;
         sxy, sxxy, sxyy, sxxxy, sxyyy, sxxyy;];
     
    
    sI = sum(I); %Construct matrix [K]
    sxI = sum(x .* I);
    syI = sum(y .* I);
    sxxI = sum(x .* x .* I);
    syyI = sum(y .* y .* I);
    sxyI = sum(x .* y .* I);
    K = [sI, sxI, syI, sxxI, syyI, sxyI]';
    
    
    a = C\K; %Solve for a %C*a = K
    
    [rows, cols] = size(im); %Remove background %First, compute the background image
    [x, y] = meshgrid(1:cols, 1:rows);
    back = a(1) + a(2)*x + a(3)*y + a(4)*x.*x + a(5)*y.*y + a(6)*x.*y;
    im2 = double(im) - back;
    im2 = mat2gray(im2);
    im2 = im2uint8(im2);

end