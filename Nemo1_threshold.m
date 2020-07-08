 %对nemo鱼进行灰度值分割(阈值分割)
 %加载相应数据
 load('Mask.mat');
 load('array_sample.mat');
 c=imread('309.bmp');
 c=rgb2gray(c);%将彩色图像转换为灰度值图像
 c=double(c)/255;%归一化处理
 c1=c.*Mask;%点乘得到nemo鱼
 h = 0.65;
 figure(1);
 imshow(c1);%画出nemo鱼
 title('灰度化处理得到的nemo鱼图像');
 a=array_sample(1:5264,1);
 b=array_sample(5265:7696,1);
 figure(2);
 hist(a);
 title('标签为1的样本直方图分布');
 figure(3);
 hist(b);
 title('标签为-1的样本直方图分布');
 c2=c1;
 c2(c2<h)=0;%进行阈值分割
 figure(4);
 imshow(c2);
 title('nemo鱼白色部分图像(阈值分割)');
 c3=c1;c3(c3>h)=0;
 figure(5);
 imshow(c3);
 title('nemo鱼黄色部分图像(阈值分割)');
 [mu_a ,sigma_a ,muci_a ,sigmaci_a]=normfit(a,0.05);
 x=0:0.01:1;f1=(1/sqrt(2*pi*sigma_a))*exp((-1/2)*(x-mu_a).^2/sigma_a^2);
 [mu_b ,sigma_b ,muci_b ,sigmaci_b]=normfit(b,0.05);
 x=0:0.01:1;f2=(1/sqrt(2*pi*sigma_b))*exp((-1/2)*(x-mu_b).^2/sigma_b^2);
 figure(8);plot(x,f1,'b');title('样本灰度值正态分布');
 hold on;plot(x,f2,'r');legend('样本1','样本-1');
 [h1,p1,ci1,zval1] = ztest(a,mu_a,sigma_a,0.05,0);%进行正态分布假设检验
 [h2,p2,ci2,zval2] = ztest(b,mu_b,sigma_b,0.05,0);
