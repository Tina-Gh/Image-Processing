function [im2, a] =  autolevel_26(fname)
%function autolevel_26 finds and removes background pixels automatically.
%
%function [im2, a] = autolevel_26(fname), where 'fname' is the name of the input image 
%and 'im2' is the output image that its background has been removed. 'a' is the
%coefficient matrix in the background equation.

    %Read in the image and display it.
    im_original = imread(fname); 
    im = double(im_original);
    
    %find the coordinates of the backgroud points automatically.
    M = 16;
    N = 16;
    itr = 1;
    x = zeros(((size(im, 1)/M) * (size(im, 2)/N)), 1); %size(im, 1)/M = size(im, 2)/N
    y = zeros(((size(im, 1)/M) * (size(im, 2)/N)), 1);
    I = zeros(((size(im, 1)/M) * (size(im, 2)/N)), 1);
    for i = M:M:size(im, 1) %move along the rows
        for j = N:N:size(im, 2) %move along the columns
            block = im((i-M+1):i, (j-N+1):j); %A block pf the input image
            [min_value_row, min_index_row] = min(block); %find the minimum value %both are vectors
            [min_value_col, min_index_col] = min(min_value_row); %both are numbers
            min_index_row = min_index_row(min_index_col); %is a number
            %Thus, the indices for the min value are: min_index_row and min_index_col
            
            x(itr) = min_index_row + (i-M); %vertical vector x %correct?
            y(itr)= min_index_col + (j-N); %vertical vector y
            I(itr) = min_value_col; %vertical vector I
            itr = itr + 1; 
        end
    end
   
    
%we don't need the following three lines, because at the begining, we
%indicated x, y, and I to be vertical vetctors. But if we don't declare
%that condition at the beginning, we have to add the following three lines as well.
%     x = x'; 
%     y = y';
%     I = I';
    
    figure(1), imshow(im_original);
    hold on
    plot(x, y, 'y+');
    hold off

    %Construct matrix C    
    N = length(x); 
    sx = sum(x);
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
    
    %Construct matrix [K]
    sI = sum(I); 
    sxI = sum(x .* I);
    syI = sum(y .* I);
    sxxI = sum(x .* x .* I);
    syyI = sum(y .* y .* I);
    sxyI = sum(x .* y .* I);
    K = [sI, sxI, syI, sxxI, syyI, sxyI]';
    
    %Solve for a %C*a = K
    a = C\K;
    
    %Remove background 
    %First, compute the background image
    [rows, cols] = size(im_original); 
    [x, y] = meshgrid(1:cols, 1:rows);
    back = a(1) + a(2)*x + a(3)*y + a(4)*x.*x + a(5)*y.*y + a(6)*x.*y;
    im2 = double(im_original) - back; %Convert image of type uint8 to matrix of type double
    im2 = mat2gray(im2); %Convert matrix to gray-level image
    im2 = im2uint8(im2); %Convert to uint8 image
 
end
