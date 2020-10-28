## Asssignment 1

<strong>Gray levels and pixels:</strong> Write a MATLAB function that accepts a uint8 image matrix called im and a 1xN vector v of strictly increasing gray-level values; N is the length of vector v. This function should return as output a 1x(N-1) row vector, y, where y(i) is the total number of pixels in im that satisfy v(i) ≤ im < v(i+1). The function header should be:

function y = countGL_#( im, v )
