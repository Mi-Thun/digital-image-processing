%%
%1.	Segment the tumor from Region growing approach
I = rgb2gray(im2double(imread('Tumor.png')));
J=imadjust(I,[],[],0.5);
J=imgaussfilt(J);
J= regiongrowing(J,0.2);
figure, imshowpair(I,J,'montage')
%%
%split&merge
I2 = imread('Tumor.tif');
g = splitmerge(I2,8,@predicate);
figure,subplot(1,2,1);imshow(I2,[]);
subplot(1,2,2);imshow(g,[]);

%%
%watershed
x=imbinarize(rgb2gray(imread('Tumor.png')));
subplot(2,2,1);
imshow(x);
title('Original Image');
a=x;
x=~x;
ms=bwdist(x);
ms=255-uint8(ms);
subplot(2,2,2);
imshow(ms);
title('Image after applying Distance Transformation');
hs=watershed(ms);
ws=hs==0;
subplot(2,2,3);
imshow(a | ws);
title('Watershed Segmentation of the image');
subplot(2,2,4);
imshow(label2rgb(hs));
title('Visualization of different segments with different color');
%%
%5 
%generate binary mask
rgb = imread('Tumor.png');
I = rgb2gray(rgb);
gmag = imgradient(I);
L = watershed(gmag);
Lrgb = label2rgb(L);
se = strel('disk',20);
Io = imopen(I,se);
Ie = imerode(I,se);
Iobr = imreconstruct(Ie,I);
Ioc = imclose(Io,se);
Iobrd = imdilate(Iobr,se);
Iobrcbr = imreconstruct(imcomplement(Iobrd),imcomplement(Iobr));
Iobrcbr = imcomplement(Iobrcbr);
fgm = imregionalmax(Iobrcbr);
figure,imshow(fgm)
%%
%dialation
se = strel('line',11,90);
BW2 = imdilate(fgm,se);
imshow(BW), title('Original')
figure, imshow(BW2), title('Dilated')
figure,imshow(fgm)
%%
%erosion
se = strel('line',11,90);
erodedBW = imerode(fgm,se);
figure,imshow(erodedBW), title('Erode')
figure,imshow(fgm)
%%
I = imread('2.png');
% I=rgb2gray(I);
s = qtdecomp(I,0.2,[2 64]);
[i,j,blksz] = find(s);
blkcount = length(i);
avg = zeros(blkcount,l);
for k=1:blkcount
    avg(k)=mean2(I(i(k):i(k)+blksz(k)-1,j(k):j(k)+blksz(k)-1));
end
avg=unit8(avg);
figure,imshow((full(s)));title('QD');drawnow;
%%
%load imdemos coins2
I = imread('Tumor.png');
I=rgb2gray(I);
Ifilt = medfilt2(I,[8 8]);
[S] = qtdecomp_var(I,10);
[Sfilt] = qtdecomp_var(Ifilt);
blocks = repmat(uint8(0),size(S));
for dim = [256 128 64 32 16 8 4 2 1];    
  numblocks = length(find(S==dim));    
  if (numblocks > 0)        
    values = repmat(uint8(1),[dim dim numblocks]);
    values(2:dim,2:dim,:) = 0;
    blocks = qtsetblk(blocks,S,dim,values);
  end
end
blocks(end,1:end) = 1;
blocks(1:end,end) = 1;
blocks_filt = repmat(uint8(0),size(Sfilt));
for dim = [128 64 32 16 8 4 2 1];    
  numblocks = length(find(Sfilt==dim));    
  if (numblocks > 0)        
    values = repmat(uint8(1),[dim dim numblocks]);
    values(2:dim,2:dim,:) = 0;
    blocks_filt = qtsetblk(blocks_filt,Sfilt,dim,values);
  end
end
blocks_filt(end,1:end) = 1;
blocks_filt(1:end,end) = 1;
figure;subplot(221);imshow(I); title('Input image');
subplot(222);imshow(Ifilt); title('Filtered image');
subplot(223);imshow(blocks,[]);title('Quad tree input image with var weight');
subplot(224);imshow(blocks_filt,[]);title('Quad tree filtered image without var weight');
%%
whos I

%%
image=rbg2gray(imread('Tumor.png'));
% Choose different scales
% Segmentation parameter Q; Q small few segments, Q large may segments
Qlevels=2.^(8:-1:0);
% This creates the following list of Qs [256 128 64 32 16 8 4 2 1]
% Creates 9 segmentations
[maps,images]=srm(image,Qlevels);
% And plot them
srm_plot_segmentation(images,maps);


%%
I = imread('Tumor.png');
g = splitmerge(I,8,@predicate);
figure,imshow(g)

%%

rgb = imread('Tumor.png');
I = rgb2gray(rgb);
gmag = imgradient(I);
L = watershed(gmag);
Lrgb = label2rgb(L);
se = strel('disk',20);
Io = imopen(I,se);
Ie = imerode(I,se);
Iobr = imreconstruct(Ie,I);
Ioc = imclose(Io,se);
Iobrd = imdilate(Iobr,se);
Iobrcbr = imreconstruct(imcomplement(Iobrd),imcomplement(Iobr));
Iobrcbr = imcomplement(Iobrcbr);
fgm = imregionalmax(Iobrcbr);
imshowpair(rgb,fgm,'montage')




