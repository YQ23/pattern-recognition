 %采用直方图对RGB进行分割
 load('Mask.mat');
 load('array_sample.mat');
 c=imread('309.bmp');
 c=double(c)/255;%归一化处理
 c1=c.*Mask;%点乘得到nemo鱼
 figure(1);
 imshow(c1);%画出nemo鱼
 title('原始nemo鱼图像');
 a2=array_sample(1:5264,2);
 a3=array_sample(1:5264,3);
 a4=array_sample(1:5264,4);
 n = 20;
 figure(2); 
 subplot(2,3,1);hist(a2,n);h_a2=hist(a2,n);g_a2=h_a2/sum(h_a2);title('样本1R通道');
 subplot(2,3,2); hist(a3,n);h_a3=hist(a3,n);g_a3=h_a3/sum(h_a3);title('样本1G通道');
 subplot(2,3,3); hist(a4,n);h_a4=hist(a4,n);g_a4=h_a4/sum(h_a4);title('样本1B通道');
 b2=array_sample(5265:7696,2);
 b3=array_sample(5265:7696,3);
 b4=array_sample(5265:7696,4);
 subplot(2,3,4); hist(b2,n);h_b2=hist(b2,n);g_b2=h_b2/sum(h_b2);title('样本-1R通道');
 subplot(2,3,5); hist(b3,n);h_b3=hist(b3,n);g_b3=h_b3/sum(h_b3);title('样本-1G通道');
 subplot(2,3,6); hist(b4,n);h_b4=hist(b4,n);g_b4=h_b4/sum(h_b4);title('样本-1B通道');
 g_a=array_sample(1:5264,1);
 g_b=array_sample(5265:7696,1);
   
 figure(8);
 hist(g_a,n);
 hh1 = hist(g_a,n);
 title('标签为1的样本灰度值直方图分布');
 g_aa = hh1 / sum(hh1);
 figure(9);
 hist(g_b,n);
 hh2 = hist(g_b,n);
 title('标签为-1的样本灰度值直方图分布');
 g_bb = hh2 / sum(hh2);
 gg=[g_a2;g_a3;g_a4;g_b2;g_b3;g_b4];
% cc = c1;
%  for i = 1:240
%      for j = 1:320
%          if(c1(i,j,:)~=0)
%              l_a2 = norm_cal(c1(i,j,1),mu_ra,sigma_ra);
%              l_a3 = norm_cal(c1(i,j,2),mu_ga,sigma_ga);
%              l_a4 = norm_cal(c1(i,j,3),mu_ba,sigma_ba);
%              l_b2 = norm_cal(c1(i,j,1),mu_rb,sigma_rb);
%              l_b3 = norm_cal(c1(i,j,2),mu_gb,sigma_gb);
%              l_b4 = norm_cal(c1(i,j,3),mu_bb,sigma_bb);
%              if(l_a2 + l_a3 + l_a4 >= l_b2 + l_b3 + l_b4)
%                  cc(i,j,:) = 1;
%              else
%                  cc(i,j,:) = -1;
%              end
%          end
%      end
%  end






 cc = c1;
 for i = 1:240
     for j = 1:320
         if(c1(i,j,:)~=0)
             l_a2 = hist_cal(c1(i,j,1),g_a2);
             l_a3 = hist_cal(c1(i,j,2),g_a3);
             l_a4 = hist_cal(c1(i,j,3),g_a4);
             l_b2 = hist_cal(c1(i,j,1),g_b2);
             l_b3 = hist_cal(c1(i,j,2),g_b3);
             l_b4 = hist_cal(c1(i,j,3),g_b4);
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
 title('nemo鱼彩色部分图像(直方图处理)');
 figure(15);
 imshow(cc_2);
 title('nemo鱼白色部分图像(直方图处理)');
                                


function  p = hist_cal(x,t)%x为输入进来的横坐标，t为1*20的列向量
x = floor(x / 0.05);
p = t(1,x+1);                                   
end




