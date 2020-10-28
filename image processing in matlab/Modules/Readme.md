## Modules:


#### Module 1: 

--

#### Module 2:

- im = imread('pout.tif');
- im = iminfo('pout.tif');
- im = imwrite(im, 'pout.tif');

***

- figure(1), imshow(im);
- colorbar

***

- impixelinfo
- imdistline
- improfile()

***

- mean2(im)
- std2(im)

***
Assignment 1: (y = countGL_26(im, v))

- row = uint8(0:255); (-> create an uint8 image (gray-level image))
  im = repmat(row, 100, 1);
  imshow(im);
  >> 1b_26.tif (-> other non-related codes were done too. like: xlabel, ...)
  
- v = [0, 256];
  N = countGL_26(im, b); (-> Number of gray levels)
  >> size(im, 1) * size(im, 2)


#### Module 3:

- ([H, D] = )imhist(im); (-> plot the Histogram of im)

***

- th = graythresh(im); (-> finds the threshold for further binarization)
- bw = im2bw(im, th); (-> converts gray-level image to a binary image (= Binarization))

***
Assignment 2: (T = intermeans_26(im);)

- im = imread('rice.png');
  T = intermeans_26(im);
  >> 0.5137
  
- bw = im2bw(im, T);
  figure(2), imshow(bw); 
  >> binary_rice.tif (-> some grains have gray levels below the threshold. Therefore, after biniraziation, they will be missed.)
  
- [label_im, number_rice] = bwlabel(bw);
  number_rice
  >> 151 (-> [im, N] = bwlabel(bw) where N is the number of connected components (8-connected, i.e. pixels that their edges or corners touch) in binary image bw.)

- p = 5;
  bw2 = bwareaopen(bw, p);
  figure(3), imshow(bw2)
  >> denoised_rice.tif (-> bw2 = bwareaopen(bw, p) this function removes all connected components (objects) that have fewer than p pixels from the binary image bw, producing                            another binary image, BW2. This operation is known as an area opening. Therefore, the larger the p, the more likly it is for the bwareaopen                                    function to remove more noise in the image bw and result in a more denoised image bw2.)
  
- [denoised_label_im, number_denoised] = bwlabel(bw2);
  number_denoised
  >> 97


#### Module 4:

- im2 = a*im + b; (-> point operation)
- imcontrast (-> Window & Level in an interactive way)
- im2 = histeq(im) (-> histogram equalization)
- match.m (in practice problems uploaded by prof. Ladak -> for histogram matching)
- question2_b.m (in practice problems written by me -> Window & Level algorithm! to enhance an image contrast!)

***
Assignment 3: (im2 = myequalize_26(im);)
  
- im = imread('pout.tif');
  im2 = myequalize_26(im);
  >> ("3b_26.tif") (-> image equalization algorithm, similar to "histeq(im)")


#### Module 5:

- im1 = double(im1);
  im2 = double(im2);
  im3 = im1 + im2; (-> Do the math part)
  im3 = mat2gray(im3);
  im3 = im2uint8(im3);
  
  
  
  
  
  


