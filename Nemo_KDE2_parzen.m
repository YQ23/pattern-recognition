%使用parzen窗函数对nemo鱼进行分离
%本程序所需时间较长，大约需要一个多小时，但效果较好
load('data.mat');
load('mask.mat');
load('array_sample.mat');
fish=imread('309.bmp');
data=array_sample;
mask=Mask;

ifelse=@(a,b,c)(a~=0)*b+(a==0)*c; 

 for i=25:175
     for j=80:185
       label1=0;label2=0;
        for k=1:5264
        label1=label1+mvnpdf(double([fish(i,j,1),fish(i,j,2),fish(i,j,3)])/255,[data(k,2),data(k,3),data(k,4)],eye(3));
        end
        for k=5265:7696
        label2=label2+mvnpdf(double([fish(i,j,1),fish(i,j,2),fish(i,j,3)])/255,[data(k,2),data(k,3),data(k,4)],eye(3));
        end
        fish_label1(i,j)=ifelse(label1/5264>label2/2432,1,0);
        fish_label2(i,j)=ifelse(label1/5264>label2/2432,0,1);
     end
  end 

fish_label1_end=double(fish)/255.*repmat(fish_label1,1,1,3).*repmat(mask,1,1,3);
fish_label2_end=double(fish)/255.*repmat(fish_label2,1,1,3).*repmat(mask,1,1,3);
subplot(1,2,1);
title('nemo鱼彩色部分图像(parzen窗)');
imshow(fish_label1_end);
subplot(1,2,2);
title('nemo鱼白色部分图像(parzen窗)');
imshow(fish_label2_end);