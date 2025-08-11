%% DEMO script to visualize the scalar prduct between two functions
clear all
close all
% some parameters
fs = 1000;
T = 100;
t = 0:1/fs:T-1/fs;
f_sig = 5;
phi_sig = 2*pi*1/10;

% path and fname_prefix                   
path2pics = ['..' filesep 'pics' filesep 'lecture_03-movie-scalarProduct', filesep];
fname_pre = 'lecture_03-movie_scalarProduct_';
fname_post = '.png';
format = '-dpng';
res = '-r300';


% plotting stuff
f_height = .4; 
fL_width = .5;
fR_width = .3;
f_deltax = 1-fL_width-fR_width;
f_deltay = .1;

cols = [0 0 .6; .6 0 0; 0 .6 0; 0 0 0];
msize = 6;
lwidth = 1.6;

n = fs*T;

% the polar dummy
xcirc = cos(2*pi*t);
ycirc = sin(2*pi*t);


% the signals
sig = sin(2*pi*f_sig*t+phi_sig);

sin_sig = -sin(2*pi*f_sig*t);
cos_sig = cos(2*pi*f_sig*t);

sin_2sig = -sin(2*pi*2*f_sig*t);
cos_2sig = cos(2*pi*2*f_sig*t);

% now the point-wise multiplications
sig_sin_sig = sig.*sin_sig;
sig_cos_sig = sig.*cos_sig;

sig_sin_2sig = sig.*sin_2sig;
sig_cos_2sig = sig.*cos_2sig;

% plot the signal and the "templates"
% the nonmatching
axes('Position',[.1 .1 fL_width f_height])
htu = plot(t,sig,'Color',cols(1,:),'Linewidth',lwidth);hold on;
plot(t,sin_2sig,'Color',cols(2,:),'Linestyle',':');
plot(t,cos_2sig,'Color',cols(3,:),'Linestyle',':');
hs_l = plot(t,sig_sin_2sig,'Color',cols(2,:),'Linestyle','-','Linewidth',lwidth*2/3);
hc_l = plot(t,sig_cos_2sig,'Color',cols(3,:),'Linestyle','-','Linewidth',lwidth*2/3);

xlabel('t / time')
ylabel('amplitude / a.u.')
xlim([0 1])
ylim([-1.1 1.1])
legend('signal','sin(2\omega t)','cos(2\omega t)')

% the 'polar' plot
axes('Position',[fL_width+f_deltax .1 fR_width f_height])
plot(xcirc,ycirc,'Color','k'); hold on;
xlabel('real part')
ylabel('imaginary part')
axis square
line([-1.1 1.1],[0 0],'Color','k')
line([0 0],[-1.1 1.1],'Color','k')
xlim([-.6 .6])
ylim([-.6 .6])

h_real_l = line([0 sum(sig_cos_2sig)/n],[0 -0*sum(sig_sin_2sig)/n],'Color',cols(3,:),'Linewidth',2*lwidth);
h_imag_l = line([0 0*sum(sig_cos_2sig)/n],[0 -sum(sig_sin_2sig)/n],'Color',cols(2,:),'Linewidth',2*lwidth);
h_full_l = line([0 sum(sig_cos_2sig)/n],[0 -sum(sig_sin_2sig)/n],'Color',cols(4,:),'Linewidth',2*lwidth);

%return

% dummy plot
% Z = eig(randn(20,20));
% h = compass(1 * ones(size(Z)));hold on
% set(h, 'Visible', 'off')
% hc_u = compass(sum(sig_cos_2sig)/n+1i*sum(sig_sin_2sig)/n);
% set(hc_u,'Color',cols(4,:))
% set(gca,'ylim',[0 1.1])
% hc_real_u = compass(sum(sig_cos_2sig)+0*sum(sig_sin_2sig));
% set(hc_real_u,'Color',cols(3,:))
% hc_imag_u = compass(0*sum(sig_cos_2sig)+1i*sum(sig_sin_2sig));
% set(hc_imag_u,'Color',cols(2,:))




% the matching
axes('Position',[.1 .1+f_height+f_deltay fL_width f_height])
htl = plot(t,sig,'Color',cols(1,:),'Linewidth',lwidth);hold on;
plot(t,sin_sig,'Color',cols(2,:),'Linestyle',':');
plot(t,cos_sig,'Color',cols(3,:),'Linestyle',':');
hs_u = plot(t,sig_sin_sig,'Color',cols(2,:),'Linestyle','-','Linewidth',lwidth*2/3);
hc_u = plot(t,sig_cos_sig,'Color',cols(3,:),'Linestyle','-','Linewidth',lwidth*2/3);

xlabel('t / time')
ylabel('amplitude / a.u.')
xlim([0 1])
ylim([-1.1 1.1])
legend('signal','sin(\Omega t)','cos(\Omega t)')

% the 'polar' plot
axes('Position',[fL_width+f_deltax .1+f_height+f_deltay fR_width f_height])
plot(xcirc,ycirc,'Color','k'); hold on;
xlabel('real part')
ylabel('imaginary part')
axis square
line([-1.1 1.1],[0 0],'Color','k')
line([0 0],[-1.1 1.1],'Color','k')
xlim([-.6 .6])
ylim([-.6 .6])

h_real_u = line([0 sum(sig_cos_sig)/n],[0 -0*sum(sig_sin_sig)/n],'Color',cols(3,:),'Linewidth',2*lwidth);
h_imag_u = line([0 0*sum(sig_cos_sig)/n],[0 -sum(sig_sin_sig)/n],'Color',cols(2,:),'Linewidth',2*lwidth);
h_full_u = line([0 sum(sig_cos_sig)/n],[0 -sum(sig_sin_sig)/n],'Color',cols(4,:),'Linewidth',2*lwidth);

%save the first frame
fname = [fname_pre, '_01', fname_post];
print(res,fname,format);
%save2pdf_and_crop(fname);
%savepdf_and_crop(fname);


%% now iterate through a number of phases and replot
phases = (0:.01:1)*2*pi;

for kk = 1:length(phases)

% the signals
sig = sin(2*pi*f_sig*t+phi_sig+phases(kk));

sin_sig = -sin(2*pi*f_sig*t);
cos_sig = cos(2*pi*f_sig*t);

sin_2sig = -sin(2*pi*2*f_sig*t);
cos_2sig = cos(2*pi*2*f_sig*t);

% now the point-wise multiplications
sig_sin_sig = sig.*sin_sig;
sig_cos_sig = sig.*cos_sig;

sig_sin_2sig = sig.*sin_2sig;
sig_cos_2sig = sig.*cos_2sig;

% substitute data
set(htl,'ydata',sig);
set(htu,'ydata',sig);

set(hs_u,'ydata', sig_sin_sig);
set(hc_u,'ydata', sig_cos_sig);

set(hs_l,'ydata', sig_sin_2sig);
set(hc_l,'ydata', sig_cos_2sig);

% the polar plots
set(h_real_u,'Xdata',[0 sum(sig_cos_sig)/n])
set(h_imag_u,'Ydata',[0 sum(sig_sin_sig)/n])
set(h_full_u,'Xdata',[0 sum(sig_cos_sig)/n], 'Ydata', [0 sum(sig_sin_sig)/n])

set(h_real_l,'Xdata',[0 sum(sig_cos_2sig)/n])
set(h_imag_l,'Ydata',[0 sum(sig_sin_2sig)/n])
set(h_full_l,'Xdata',[0 sum(sig_cos_2sig)/n], 'Ydata', [0 sum(sig_sin_2sig)/n])

fname = [path2pics, fname_pre, num2str(kk), fname_post];
print(res,fname,format);
%pause(.1)
end

