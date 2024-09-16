close all
clear all

% get random numbers with defined seed
randn('seed',0);
x = fix(10*randn(20,1));
n = 1:length(x);

% filter coefficients
A = 1;  %iir
B3 = [1 1 1]/3; % 2nd order running sum
B5 = [1 1 1 1 1]/5; % 4th order running sum

y3 = filter(B3,A,x);
y5 = filter(B5,A,x);

%plotting of stuff
% plotting stuff
cols = [0 0 .6; .6 0 0; 0 .6 0];

%figure
%set(gcf,'paperunits','centimeters','Paperposition',[0 0 10 6])
prepare_figure_scale(10,7.5);

set(gca,'Fontsize',12)

xlabel('sample number')
ylabel('value')

% first plot with samples and lines
h1 = stem(n,x,'k'); hold on;
%plot(n(1:3),x(1:3),'ok');
ylim([-22 22])
legend('original')
set(h1,'Linewidth',1)
xlabel('sample number')
ylabel('value')
filename = '../pics/lecture_02_rs0.pdf';
save2pdf_and_crop(filename);


%and then the filtered versions
prepare_figure_scale(10,7.5);

set(gca,'Fontsize',12)

xlabel('sample number')
ylabel('value')

h1 = plot(n,x,'k-'); hold on;
%plot(n(1:3),x(1:3),'ok');
ylim([-22 22])
legend('original')
set(h1,'Linewidth',1)
xlabel('sample number')
ylabel('value')

filename = '../pics/lecture_02_rs1.pdf';
save2pdf_and_crop(filename);
%saveas(gcf,'../pics/lecture2_rs1.eps','psc2')

%prepare_figure();
h3 = plot(n,y3,'Color',cols(2,:)); 
%plot(n(1:3),y3(1:3),'or');
legend('original','order 2')
set(h3,'Linewidth',1)
filename = '../pics/lecture_02_rs3.pdf';
save2pdf_and_crop(filename);
%saveas(gcf,'../pics/lecture2_rs3.eps','psc2')

%prepare_figure();
h5 = plot(n,y5,'Color',cols(1,:)); 
%plot(n(1:3),y5(1:3),'ob');
legend('original','order 2','order 4')
set(h5,'Linewidth',1)

filename = '../pics/lecture_02_rs5.pdf';
save2pdf_and_crop(filename);
%saveas(gcf,'../pics/lecture2_rs5.eps','psc2')

%%%
