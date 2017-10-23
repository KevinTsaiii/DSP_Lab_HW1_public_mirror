function output = my_imfilter(image, filter)
% This function is intended to behave like the built in function imfilter()
% See 'help imfilter' or 'help conv2'. While terms like "filtering" and
% "convolution" might be used interchangeably, and they are indeed nearly
% the same thing, there is a difference:
% from 'help filter2'
%    2-D correlation is related to 2-D convolution by a 180 degree rotation
%    of the filter matrix.
% Your function should work for color images. Simply filter each color
% channel independently.
% Your function should work for filters of any width and height
% combination, as long as the width and height are odd (e.g. 1, 7, 9). This
% restriction makes it unambigious which pixel in the filter is the center
% pixel.
% Boundary handling can be tricky. The filter can't be centered on pixels
% at the image boundary without parts of the filter being out of bounds. If
% you look at 'help conv2' and 'help imfilter' you see that they have
% several options to deal with boundaries. You should simply recreate the
% default behavior of imfilter -- pad the input image with zeros, and
% return a filtered image which matches the input resolution. A better
% approach is to mirror the image content over the boundaries for padding.
% % Uncomment if you want to simply call imfilter so you can see the desired
% % behavior. When you write your actual solution, you can't use imfilter,
% % filter2, conv2, etc. Simply loop over all the pixels and do the actual
% % computation. It might be slow.
% output = imfilter(image, filter);

R_in(:,:) = image(:,:,1);
G_in(:,:) = image(:,:,2);
B_in(:,:) = image(:,:,3);

[i_height, i_width, i_channel] = size(image);

[f_height, f_width] = size(filter);

R_out = zeros(i_height, i_width);
B_out = zeros(i_height, i_width);
G_out = zeros(i_height, i_width);

R_pad = zeros(i_height + f_height, i_width + f_width);
B_pad = zeros(i_height + f_height, i_width + f_width);
G_pad = zeros(i_height + f_height, i_width + f_width);

R_pad(1+(f_height-1)/2:i_height+(f_height-1)/2, 1+(f_width-1)/2:i_width+(f_width-1)/2) = R_in;
G_pad(1+(f_height-1)/2:i_height+(f_height-1)/2, 1+(f_width-1)/2:i_width+(f_width-1)/2) = G_in;
B_pad(1+(f_height-1)/2:i_height+(f_height-1)/2, 1+(f_width-1)/2:i_width+(f_width-1)/2) = B_in;

for m = 1:i_height
   for n = 1:i_width
       
       for k = 1:f_height
           for l = 1:f_width
               R_out(m, n) = R_out(m, n) + filter(k, l)*R_pad(m+k, n+l);
               G_out(m, n) = G_out(m, n) + filter(k, l)*G_pad(m+k, n+l);
               B_out(m, n) = B_out(m, n) + filter(k, l)*B_pad(m+k, n+l);
           end
       end
   end
end

output(:,:,1) = R_out;
output(:,:,2) = G_out;
output(:,:,3) = B_out;