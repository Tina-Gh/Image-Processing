## Modules:


#### Module 1: 

--

#### Module 2:

- im = imread('pout.tif');
- im = iminfo('pout.tif');
- im = imwrite(im, 'pout.tif');

- figure(1), imshow(im);
- colorbar

  
- impixelinfo
- imdistline
- improfile()
**
- mean2(im)
- std2(im)

***Assignment 1: (y = countGL_26(im, v))

- row = uint8(0:255); (-> create an uint8 image (gray-level image))

  im = repmat(row, 100, 1);
  
  imshow(im);

- v = [0, 256];

  N = countGL_26(im, b); (-> Number of gray levels)

#### Module 3:


#### Module 4:
- im2 = a*im + b; (-> point operation)
- imcontrast (-> Window & Level)


