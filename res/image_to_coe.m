%ADD IMAGE FILE BELOW
filename = 'pat_gen_1_img.jpg';
img = imread(filename);
img = imresize((img),[320 240]);
[ M,N,P ] = size(img);
if P == 3
    img = rgb2gray(img);
end
subplot(2,2,1) ,imshow(img);
title('ORIGINAL IMAGE');
img_N = 255 - img;
subplot(2,2,2) ,imshow(img_N);
title('MATLAB INVERTED IMAGE');
file = fopen('pat_gen_1.coe','wt');
fprintf(file,'%s\n','memory_initialization_radix=16;'); 
fprintf(file,'%s\n','memory_initialization_vector=');
for i=1:M
    for j=1:N
        fprintf(file, '%x', img(i,j));
        if(i==M && j==N)
            fprintf(file,'%c',';');
        else
            fprintf(file,'%c\n',',');
        end
    end
end
fclose(file);