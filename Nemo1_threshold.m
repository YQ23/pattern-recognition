 %��nemo����лҶ�ֵ�ָ�(��ֵ�ָ�)
 %������Ӧ����
 load('Mask.mat');
 load('array_sample.mat');
 c=imread('309.bmp');
 c=rgb2gray(c);%����ɫͼ��ת��Ϊ�Ҷ�ֵͼ��
 c=double(c)/255;%��һ������
 c1=c.*Mask;%��˵õ�nemo��
 h = 0.65;
 figure(1);
 imshow(c1);%����nemo��
 title('�ҶȻ�����õ���nemo��ͼ��');
 a=array_sample(1:5264,1);
 b=array_sample(5265:7696,1);
 figure(2);
 hist(a);
 title('��ǩΪ1������ֱ��ͼ�ֲ�');
 figure(3);
 hist(b);
 title('��ǩΪ-1������ֱ��ͼ�ֲ�');
 c2=c1;
 c2(c2<h)=0;%������ֵ�ָ�
 figure(4);
 imshow(c2);
 title('nemo���ɫ����ͼ��(��ֵ�ָ�)');
 c3=c1;c3(c3>h)=0;
 figure(5);
 imshow(c3);
 title('nemo���ɫ����ͼ��(��ֵ�ָ�)');
 [mu_a ,sigma_a ,muci_a ,sigmaci_a]=normfit(a,0.05);
 x=0:0.01:1;f1=(1/sqrt(2*pi*sigma_a))*exp((-1/2)*(x-mu_a).^2/sigma_a^2);
 [mu_b ,sigma_b ,muci_b ,sigmaci_b]=normfit(b,0.05);
 x=0:0.01:1;f2=(1/sqrt(2*pi*sigma_b))*exp((-1/2)*(x-mu_b).^2/sigma_b^2);
 figure(8);plot(x,f1,'b');title('�����Ҷ�ֵ��̬�ֲ�');
 hold on;plot(x,f2,'r');legend('����1','����-1');
 [h1,p1,ci1,zval1] = ztest(a,mu_a,sigma_a,0.05,0);%������̬�ֲ��������
 [h2,p2,ci2,zval2] = ztest(b,mu_b,sigma_b,0.05,0);
