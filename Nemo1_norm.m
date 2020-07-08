 %利用参数估计分离nemo鱼
 load('Mask.mat');
 load('array_sample.mat');
 c=imread('309.bmp');c=rgb2gray(c);%将彩色图像转换为灰度值图像
 c=double(c)/255;%归一化处理
 c1=c.*Mask;%点乘得到nemo鱼
 figure(1);
 imshow(c1);%画出nemo鱼
 title('原始nemo鱼图像');
 a1=array_sample(1:5264,1);
 [mu_a ,sigma_a ,muci_a ,sigmaci_a]=normfit(a1,0.05);


 b1=array_sample(5265:7696,1);
 [mu_b ,sigma_b ,muci_b ,sigmaci_b]=normfit(b1,0.05);

 
 cc = c1;
 for i = 1:240
     for j = 1:320
         if(c1(i,j)~=0)
             l_a1 = norm_cal(c1(i,j,1),mu_a,sigma_a);
            
             l_b1 = norm_cal(c1(i,j,1),mu_b,sigma_b);
             
             if(l_a1  >= l_b1 )
                 cc(i,j) = 1;
             else
                 cc(i,j) = -1;
             end
         end
     end
 end
 cc_1 = cc;
 cc_2 = cc;
 cc_1(cc_1<1) = 0;
 cc_2(cc_2>-0.5) = 0;
 cc_2(cc_2<-0.6) = 1;
 cc_1 = cc_1 .* c1;
 cc_2 = cc_2 .* c1;
 img_1 = cc_1 .* Mask;
 img_2 = cc_2 .* Mask;
 figure(14);
 imshow(cc_1);
 title('nemo鱼彩色部分图像(正态分布)');
 figure(15);
 imshow(cc_2);
 title('nemo鱼白色部分图像(正态分布)');
 t = 0;
for i = 0.5:0.0001:0.7
    l_a = norm_cal(i,mu_a,sigma_a);
    l_b = norm_cal(i,mu_b,sigma_b);
    t = t+1;
    if(l_a > l_b)
        flag(t,1) = i;
        flag(t,2) = 1;
    else
        flag(t,1) = i;
        flag(t,2) = -1;
    end
end

function p = norm_cal(x,mu,sigma)
p = (1/sqrt(2*pi*sigma))*exp((-1/2)*(x-mu).^2/sigma^2);
end