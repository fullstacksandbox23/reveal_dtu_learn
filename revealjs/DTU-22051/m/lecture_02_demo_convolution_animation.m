%% script to make a nice animation to visualize convolution.
close all
clear all

width=1*16;
height=1*10;

% generate the signals
L=40;
N=10;

f=zeros(L,1); g=zeros(L,1);

f(1:N+1,1)=linspace(0,1,N+1).';
f(N+1:2*N+1,1)=linspace(1,0,N+1).';

%h(1:2*N+1)=ones(2*N+1,1);
h(1:2*N+1)=exp(-(1:2*N+1)/N);

% we know that after covolution, the length will be
L_conv = length(f) + length(h) -1;

f_conv_h = zeros(L_conv,1); %dummy matrix

% zero-pad a bit
f_conv = [zeros(length(h)-1,1); f(:); zeros(length(h)-1,1)];
h_conv = [zeros(length(h)-1,1); h(:); zeros(length(f)-1,1)];

h_flip = [flipud(h_conv(1:41)); h_conv(42:end)];



n = -(length(h)-1):L_conv-1;

% some plotting stuff
lw=1;   % line width
ms=3;   % marker size
fntsize = 11;
cols = [0 0 .6; .6 0 0; 0 .6 0];    % color

%% let's do the convolution
for kk = 1:L_conv
    f_conv_h(kk) = sum(f_conv.*circshift(h_flip,kk-1));    
end

% add the leading zeros
f_conv_h = [zeros(length(h)-1,1); f_conv_h];

% prepare the plots
prepare_figure_scale(width, height)
figure
set(gcf,'paperunits','centimeters','Paperposition',[0 0 .9*width .9*height])

axes('Position',[.1 .77 .85 .18])
hf = stem(n, f_conv ,'Color',cols(1,:),'Linewidth',lw, 'Markersize', ms);
ylim([-.1 1.1])
legend('x(n)')
%xlabel('index number [k]')
%ylabel('amplitude / a.u.')
set(gca,'Fontsize',fntsize, 'xtick',[])

axes('Position',[.1 .56 .85 .18])
hh = stem(n, h_conv ,'Color',cols(2,:),'Linewidth',lw, 'Markersize', ms);
ylim([-.1 1.1])
legend('h(n)')
%xlabel('index number [k]')
ylabel('amplitude / a.u.')
set(gca,'Fontsize',fntsize, 'xtick',[])

axes('Position',[.1 .35 .85 .18])
stem(n, f_conv ,'Color',cols(1,:),'Linewidth',lw, 'Markersize', ms);
hold on
hhf = stem(n, h_flip ,'Color',cols(2,:),'Linewidth',lw, 'Markersize', ms);
xlim([-20 60])
ylim([-.1 1.1])
lhhf = legend('x(n)','h(-n)')
%xlabel('index number [k]')
%ylabel('amplitude / a.u.')
set(gca,'Fontsize',fntsize, 'xtick',[])

axes('Position',[.1 .14 .85 .18])
hconv = stem(n, zeros(length(f_conv_h),1) ,'Color',cols(1,:),'Linewidth',lw, 'Markersize', ms);
xlim([-20 60])
ylim([-1 11])
legend('x(n)*h(n)')
thconv = text(-15,5,'\Sigma x(m)\cdot h(0-m)','FontSize',1.5*fntsize);
xlabel('index number (n) / (m)')
%ylabel('amplitude / a.u.')
set(gca,'Fontsize',fntsize)

filename = '../pics/lecture_02-movie-convolution/lecture_02-convolution-frame1.pdf';
save2pdf_and_crop(filename);

%return
for kk = 21:size(f_conv_h)
%for kk = 21:22
   set(hhf,'XData',n,'YData',circshift(h_flip,kk-21))
   set(lhhf,'String',{'x(m)' ['h(' num2str(kk-21) '-m)']})
   set(hconv,'XData',n(1:kk),'YData',f_conv_h(1:kk))
   set(thconv,'String',{['\Sigma x(m)\cdot h(' num2str(kk-21) '-m)']})
   filename = ['../pics/lecture_02-movie-convolution/lecture_02-convolution-frame' num2str(kk-19) '.pdf'];
   save2pdf_and_crop(filename);
end
    
return


%plotting
prepare_figure()
%set(gcf,'paperunits','centimeters','Paperposition',[0 0 10 8])

subplot(3,1,1); stem(1:L,fp,'o','LineWidth',lw,'Markersize',ms,'Color',cols(1,:));
ylim([0 1.1])
subplot(3,1,2); stem(1:L,gp,'o','LineWidth',lw,'Markersize',ms,'Color',cols(1,:));
ylim([0 1.1])
ylabel('amplitude / a.u.')
subplot(3,1,3); stem(1:L,pconv(fp,gp),'o','LineWidth',lw,'Markersize',ms,'Color',cols(1,:));
ylim([0 11])
xlabel('sample number')

set(gca,'Fontsize',10)

%filename = '../pics/lecture2_conv1.eps';
%save2pdf_and_crop(filename);


prepare_figure();
%set(gcf,'paperunits','centimeters','Paperposition',[0 0 10 8])

subplot(3,1,1); stem(1:L,f,'o','LineWidth',lw,'Markersize',ms,'Color',cols(1,:));
ylim([0 1.1])
subplot(3,1,2); stem(1:L,g,'o','LineWidth',lw,'Markersize',ms,'Color',cols(1,:));
ylim([0 1.1])
ylabel('amplitude / a.u.')
subplot(3,1,3); stem(1:L,pconv(f,g),'o','LineWidth',lw,'Markersize',ms,'Color',cols(1,:));
ylim([0 11])
xlabel('sample number')

set(gca,'Fontsize',10)

%filename = '../pics/lecture2_conv2.eps';
%save2pdf_and_crop(filename);
%print -deps '../pics/lecture2_conv2.eps'
