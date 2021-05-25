filespath = [pwd '\'];
imagename = 'lena.jpg';

im = imread([filespath imagename]);

%%
figure;
imshow(im);

%%
figure;
I2 = rgb2gray(im);
imshow(I2);


%%
figure
subplot(1,2,1)
imshow(I3)
subplot(1,2,2)
imhist(I3)

%%
figure;
imhist(I2)

%%
I3 = histeq(I2);
figure;
imshow(I3)

%%
figure;
imhist(I3)

%%
imwrite (I3, 'lena2.jpg');

%% Šum na slici
noisyImage = imnoise(I2,'salt & pepper', 0.15);
figure
imshow(noisyImage)


imshowpair(I2,noisyImage, 'montage')

%%
% uint to double

% varijable

% petlja

%prikaz
imshowpair(A,noisyImage, 'montage')

%J = medfilt2(I,[m n]);


%% Derivacija slike
%https://www.mathworks.com/help/images/ref/imgradient.html











