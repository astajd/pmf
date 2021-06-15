%%
filespath = [pwd '\'];
imagename = 'CO358.jpg';

I = imread([filespath imagename]);

figure;
imshow(I)
title('Original Image')

%%
mask = zeros(size(I));
mask(25:end-25,25:end-25) = 1;
figure;
imshow(mask)
title('Initial Contour Location')

%%
figure;
bw = activecontour(I, mask, 800);
imshow(bw)
title('Segmented Image, 800 Iterations')

%%
im_aniso = uint8(anisodiff(I, 12, 1/7, 19, 1));
figure;
imshow(im_aniso)
%%
bw = activecontour(im_aniso, mask, 800);
figure;
imshow(bw)
title('Segmented Image, 800 Iterations')

%%
imagename = 'co358large.jpg';
I = imread([filespath imagename]);

scaling = 1;
I = imresize(I, scaling);

[~,~,o] = size(I);
if (o>=3)
    I = rgb2gray(I);
end

figure;
imshow(I, 'border', 'tight')

%%
im_aniso = uint8(anisodiff(I, 4, 1/7, 11, 1));
figure;
imshow(im_aniso, 'border', 'tight')

%%
threshold = 150; %95 
blob_size = 25; %50

imthrmask1 = im_aniso < threshold; figure; imshow(imthrmask1, [], 'border', 'tight');title('imthrmask1');
imthrmask2 = 1-im2bw(I,graythresh(I)); figure; imshow(imthrmask2, [], 'border', 'tight');title('imthrmask2');
imthrmask = imthrmask1.*imthrmask2; figure; imshow(imthrmask, [], 'border', 'tight');title('imthrmask3');
imthrmask = bwareaopen(imthrmask, blob_size); %remove small objects
figure; imshow(imthrmask, [], 'border', 'tight');title('imthrmask4');

imregmask = imregionalmin(im_aniso,8);
minima = (imregmask .* imthrmask) > 0;

%[xloc, yloc] = find(minima);


%%
D2 = imimposemin(im_aniso, minima);
Ld2 = watershed(D2);
imthrmask(Ld2 == 0) = 0;
figure;
imshow(imthrmask, 'border', 'tight');title('Final watershed');
%%
figure; 
imshowpair(im_aniso,imthrmask,'blend');title('Overlay');

%%
stats = regionprops(imthrmask);
L = bwlabel(imthrmask);


%%
allBlobAreas = [stats.Area]; 
allowableAreaIndexes = (allBlobAreas < 100);
keeperIndexes = find(allowableAreaIndexes); 
keeperBlobsImage = ismember(L, keeperIndexes); 
newLabeledImage = bwlabel(keeperBlobsImage, 8);  
imshow(newLabeledImage>0 , []);
title('"Keeper" blobs');







