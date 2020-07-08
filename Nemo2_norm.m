 %RGB分割，采用正态分布估计的方法
 load('Mask.mat');
 load('array_sample.mat');
 c=imread('309.bmp');
 c=double(c)/255;%归一化处理
 c1=c.*Mask;%点乘得到nemo鱼
 figure(1);
 imshow(c1);%画出nemo鱼
 title('原始nemo鱼图像');
 a2=array_sample(1:5264,2);
 [mu_ra ,sigma_ra ,muci_ra ,sigmaci_ra]=normfit(a2,0.05);
 x=0:0.01:1;f1=(1/sqrt(2*pi*sigma_ra))*exp((-1/2)*(x-mu_ra).^2/sigma_ra^2);
 figure(8);plot(x,f1);title('标签为1的样本R通道正态分布');
 a3=array_sample(1:5264,3);
 [mu_ga ,sigma_ga ,muci_ga ,sigmaci_ga]=normfit(a3,0.05);
 x=0:0.01:1;f1=(1/sqrt(2*pi*sigma_ga))*exp((-1/2)*(x-mu_ga).^2/sigma_ga^2);
 figure(9);plot(x,f1);title('标签为1的样本G通道正态分布');
 a4=array_sample(1:5264,4);
 [mu_ba ,sigma_ba ,muci_ba ,sigmaci_ba]=normfit(a4,0.05);
 x=0:0.01:1;f1=(1/sqrt(2*pi*sigma_ba))*exp((-1/2)*(x-mu_ba).^2/sigma_ba^2);
 figure(10);plot(x,f1);title('标签为1的样本B通道正态分布');
 figure(2); hist(a2);title('标签为1的样本R通道直方图分布');
 figure(3); hist(a3);title('标签为1的样本G通道直方图分布');
 figure(4); hist(a4);title('标签为1的样本B通道直方图分布');
 b2=array_sample(5265:7696,2);
 [mu_rb ,sigma_rb ,muci_rb ,sigmaci_rb]=normfit(b2,0.05);
 x=0:0.01:1;f1=(1/sqrt(2*pi*sigma_rb))*exp((-1/2)*(x-mu_rb).^2/sigma_rb^2);
 figure(11);plot(x,f1);title('标签为-1的样本R通道正态分布');
 b3=array_sample(5265:7696,3);
 [mu_gb ,sigma_gb ,muci_gb ,sigmaci_gb]=normfit(b3,0.05);
 x=0:0.01:1;f1=(1/sqrt(2*pi*sigma_gb))*exp((-1/2)*(x-mu_gb).^2/sigma_gb^2);
 figure(12);plot(x,f1);title('标签为-1的样本G通道正态分布');
 b4=array_sample(5265:7696,4);
 [mu_bb ,sigma_bb ,muci_bb ,sigmaci_bb]=normfit(b4,0.05);
 x=0:0.01:1;f1=(1/sqrt(2*pi*sigma_bb))*exp((-1/2)*(x-mu_bb).^2/sigma_bb^2);
 [h_r1,p_r1,ci_r1,zval_r1] = ztest(a2,mu_ra,sigma_ra,0.05,0);%进行正态分布假设检验
 [h_g1,p_g1,ci_g1,zval_g1] = ztest(a3,mu_ga,sigma_ga,0.05,0);
 [h_b1,p_b1,ci_b1,zval_b1] = ztest(a4,mu_ba,sigma_ba,0.05,0);
 [h_r2,p_r2,ci_r2,zval_r2] = ztest(b2,mu_rb,sigma_rb,0.05,0);
 [h_g2,p_g2,ci_g2,zval_g2] = ztest(b3,mu_gb,sigma_gb,0.05,0);
 [h_b2,p_b2,ci_b2,zval_b2] = ztest(b4,mu_bb,sigma_bb,0.05,0);
 
 figure(13);plot(x,f1);title('标签为-1的样本B通道正态分布');
 figure(5); hist(b2);title('标签为-1的样本R通道直方图分布');
 figure(6); hist(b3);title('标签为-1的样本G通道直方图分布');
 figure(7); hist(b4);title('标签为-1的样本B通道直方图分布');
 
 cc = c1;
 for i = 1:240
     for j = 1:320
         if(c1(i,j,:)~=0)
             l_a2 = norm_cal(c1(i,j,1),mu_ra,sigma_ra);
             l_a3 = norm_cal(c1(i,j,2),mu_ga,sigma_ga);
             l_a4 = norm_cal(c1(i,j,3),mu_ba,sigma_ba);
             l_b2 = norm_cal(c1(i,j,1),mu_rb,sigma_rb);
             l_b3 = norm_cal(c1(i,j,2),mu_gb,sigma_gb);
             l_b4 = norm_cal(c1(i,j,3),mu_bb,sigma_bb);
             if(l_a2 + l_a3 + l_a4 >= l_b2 + l_b3 + l_b4)
                 cc(i,j,:) = 1;
             else
                 cc(i,j,:) = -1;
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


function p = norm_cal(x,mu,sigma)
p = (1/sqrt(2*pi*sigma))*exp((-1/2)*(x-mu).^2/sigma^2);
end
 