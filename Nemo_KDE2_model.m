 %��nemo�����RGB�ָ�
 %������Ӧ����
 load('Mask.mat');
 load('array_sample.mat');
 c=imread('309.bmp');

 c=double(c)/255;%��һ������
 c1=c.*Mask;%��˵õ�nemo��

 a_2=array_sample(1:5264,2);
 a_3=array_sample(1:5264,3);
 a_4=array_sample(1:5264,4);
 a = array_sample(1:5264,2:4);
 b_2=array_sample(5265:7696,2);
 b_3=array_sample(5265:7696,3);
 b_4=array_sample(5265:7696,4);
 b = array_sample(5264:7696,2:4);

cc = c1;
for i = 1:240
     for j = 1:320
         if(c1(i,j,:)~=0)
             xx = [c1(i,j,1),c1(i,j,2),c1(i,j,3)];
             pred = trainedModel_g2.predictFcn(xx); 
              % trainedModel_g2Ϊʹ��MATLAB���������ѵ����õ���ģ��
             if(pred==1)
                 cc(i,j,:) = 1;
             else
                 cc(i,j,:) = -1;
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
 title('nemo���ɫ����ͼ��(KDE����)');
 figure(3);
 imshow(c_b);
 title('nemo���ɫ����ͼ��(KDE����)');