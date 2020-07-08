 %对nemo鱼进行灰度值分割
 %加载相应数据
 load('Mask.mat');
 load('array_sample.mat');
 c=imread('309.bmp');
 c=rgb2gray(c);%将彩色图像转换为灰度值图像
 c=double(c)/255;%归一化处理
 c1=c.*Mask;%点乘得到nemo鱼
 %h = 0.65;
 
 a=array_sample(1:5264,1);
 b=array_sample(5265:7696,1);

 train_data = [a;b];
 train_label = array_sample(:,5);
 figure(1);
 imshow(c1);%画出nemo鱼

n1 = 5264;
n2 = 2432;
min_a = min(a);
max_a = max(a);
min_b = min(b);
max_b = max(b);
da = (max_a-min_a)/n1;
db = (max_b-min_b)/n2;
x1 = min_a:da:max_a-da;
x2 = min_b:db:max_b-db;
h=0.5;
f1=zeros(1,n1);
f2=zeros(1,n2);
for j = 1:n1
    for i=1:n1
        f1(j)=f1(j)+exp(-(x1(j)-a(i))^2/2/h^2)/sqrt(2*pi);
    end
    f1(j)=f1(j)/n1/h;
end
figure(4);
plot(x1,f1);
for j = 1:n2
    for i=1:n2
        f2(j)=f2(j)+exp(-(x2(j)-b(i))^2/2/h^2)/sqrt(2*pi);
    end
    f2(j)=f2(j)/n2/h;
end
figure(5);
plot(x2,f2);

cc = c1;
for i = 1:240
     for j = 1:320
         if(c1(i,j)~=0)
             pred = trainedModel_g.predictFcn(c1(i,j));
            % trainedModel_g为使用MATLAB工具箱进行训练后得到的模型
             if(pred==1)
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
 title('nemo鱼黄色部分图像(KDE处理)');
 figure(3);
 imshow(c_b);
 title('nemo鱼白色部分图像(KDE处理)');