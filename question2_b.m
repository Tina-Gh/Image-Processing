%% Solution 1:

clear
clc
close all

w = 38;
L = 74;
start_ind = L - w/2;
end_ind = L + w/2;

im = imread('head.tif');
figure(1), imshow(im);
len_im = size(im);
[h, D] = imhist(im);
h = h.';

a = 255 / (end_ind - start_ind);
b = start_ind;
f1 = a * ((start_ind:end_ind) - b);

for i = 1:start_ind+1
    h(i) = 0;
end

j = 1;
for i = start_ind+1:end_ind+1
    h(i) = f1(j);
    j = j + 1;
end

for i = end_ind+1:256
    h(i) = 256;
end

h = uint8(round(h));
im2 = h(double(im)+1);
figure(2), imshow(im2);
figure(3), imhist(im2);
set(gca, 'xlim', [0 255], 'ylim', [0 300]); % Pretty up axes
figure(4), plot(D, h);
xlabel('Gray level, D');
ylabel('f1(D)');


%% Solution 2:

clear
clc

w = 38;
L = 74;

im = imread('head.tif');
f1 = [zeros(1, L-w/2+1), (255/w)*(1:1:w), 255*ones(1, 255-(L+w/2))];
%or: f1 = [zeros(1, L-w/2+1), (255/w)*((L-w/2+1:1:L+w/2)-L+w/2), 255*ones(1, 255-(L+w/2))];
f1 = uint8(round(f1));
im2 = f1(double(im)+1); %!!imp!!

gl = 0:1:255;
subplot(221), plot(gl,f1);
set(gca, 'xlim', [0 255], 'ylim', [0 300]); % Pretty up axes
xlabel('Gray level, D');
ylabel('f1(D)');
title('Window and Level Function');
subplot(223), imshow(im);
title('Original Image');
subplot(224), imshow(im2);
title('Image after W&L');