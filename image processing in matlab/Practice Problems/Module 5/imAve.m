function imAve(fname, M)
%imAve function Demonstrates noise reduction by image averaging.
%
%imAve(fname, M) where fname is a string containing the filename of
%the file in which the image is stored and M is the number of noisy
%images to average. ( M = 4, 9, 16)

    im = imread(fname);
    
    var = 0.01; % Variance of noise (using Gaussian noise pdf)
    m = 0; % Zero mean noise (using Gaussian noise pdf)
    sum = zeros(size(im));
    for i = 1:1:M % Generate n noisy images and average them together
        sum = sum + double(imnoise(im, 'gaussian', m, var));
    end
    avg = sum / M;
    avg = uint8(avg);
    
    % Display typical noisy image (single acquisition) and averaged image:
    figure(1), subplot(211), imshow(imnoise(im, 'gaussian', m, var));
    subplot(212), imshow(avg);
    
end