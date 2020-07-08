 %对nemo鱼进行灰度值分割(KNN)
 %加载相应数据
 load('Mask.mat');
 load('array_sample.mat');
 c=imread('309.bmp');
 c=rgb2gray(c);%将彩色图像转换为灰度值图像
 c=double(c)/255;%归一化处理
 c1=c.*Mask;%点乘得到nemo鱼

 a=array_sample(1:5264,1);
 b=array_sample(5265:7696,1);
 train_data = [a;b];
 train_label = array_sample(:,5);
 figure(1);
 imshow(c1);%画出nemo鱼

 k = fitcknn(train_data,train_label,'NumNeighbors',5);
 cc = c1;
 for i = 1:240
     for j = 1:320
         if(c1(i,j)~=0)
             pred = predict(k,c1(i,j));
             if(pred == 1)
                 cc(i,j) = 1;
             else
                 cc(i,j) = -1;
             end
         end
     end
 end
 c_a = cc;
 c_b = cc;
 c_a(c_a<1)=0;
 c_a = c_a .* c1;
 c_b(c_b>-0.5)=0;
 c_b(c_b<-0.6)=1;
 c_b = c_b .* c1;
 figure(2);
 imshow(c_a);
 title('nemo鱼黄色部分图像(KNN处理)');
 figure(3);
 imshow(c_b);
 title('nemo鱼白色部分图像(KNN处理)');