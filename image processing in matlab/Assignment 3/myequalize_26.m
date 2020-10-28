function im2 = myequalize_26(im)
%function myequalize_26 implements the histogram equalization algorithm.
%
%function im2 = myequalize_26(im) where im is a uint8 grayscale image 
%(like pout.tif in MATLAB), im2 is the uint8 output image.

    [h_A, D_A] = imhist(im);
    h_A = h_A.';
    len_im = size(im);
    
    vec = zeros(1, length(h_A));
    for i = 1:1:length(D_A)
        vec(i) = sum(h_A(1:i));
    end
    
    A0 = vec(end); %or sum(h_A(1:end))
    D_B = D_A(end) / A0 * vec; %D_B = f(D_A) %D_A(end)= 255 for uint8 images
    D_B = round(D_B);

%     D_B = uint8(round(D_B));
%     im2 = D_B(double(im)+1);
%or:
    im2 = im; %simply declaring uint8 variable im2
    for i = 1:1:len_im(1)
        for j  = 1:1:len_im(2)
            for k = 1:1:length(D_A)
                if im(i, j) == D_A(k) %im(i, j) has D_A values
                    im2(i, j) = D_B(k); %im2(i, j) is being assigned D_B values
                end
            end
        end
    end
end