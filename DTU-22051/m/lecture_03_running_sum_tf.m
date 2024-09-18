% lecture 3 - Transfer function of running sum filter
close all;
%savefig([filename, 'pdf');

%some parameters
fs = 44100;
T = .01;
t = 0:1/fs:T-1/fs;
f = -fs/2:1/T:fs/2-1/T;

% plotting stuff
cols = [0 0 .6; .6 0 0; 0 .6 0];
%%%%%%%%%%%%% order 3
%the IR
h = [1 1 1]/3; % 3rd order running sum

% define the signal
sig = [h(:); zeros(fs*T-length(h),1)];
% sig = [h(:); zeros(fs*T-length(h),1)];

%FFTinf
Y = fft(sig)/(fs*T);
%do a correction to get rid of rounding errors during FFT
%Y_corr = Y.*(abs(Y)>4*eps);
Y_phase = angle(Y)/(pi);


%plotting
%prepare_figure();
figure
set(gcf,'paperunits','centimeters','Paperposition',[0 0 15 12])

axes('Position',[.1 .6 .86 .3])
ht1 = stem(t*1000,sig,'Color',cols(1,:));
title('time signal (impulse response)')
xlabel('time / ms')
ylabel('amplitude / a.u.')
ylim([0 1.1*max(sig)])
xlim([-1/fs T+1/fs]*1000)

axes('Position',[.3 .7 .56 .15])
ht2 = stem([0:10],sig(1:11),'Color',cols(1,:));
xlabel('sample nr.')
%ylabel('amplitude / a.u.')
xlim([-1 11])
ylim([0 1.1*max(sig)])

axes('Position',[.1 .15 .86 .3])
hY = plot(f/1000,fftshift(abs(Y))/max(abs(Y)),'Color',cols(1,:))
xlim([-fs/2/1000 fs/2/1000])
title('magnitude (of transfer function)')
xlabel('frequency / kHz')
ylabel('amplitude (normalized)')

%cometics
set([ht1 ht2 hY],'Linewidth',2,'Markersize',6)

%saving
filename = '../pics/lecture_03_running_sum_tf.svg';
saveas(gcf, filename,'svg')
%save2pdf_and_crop(filename);
%savefig('../pics/lecture3_running_sum_tf', 'pdf');


%% magnitude and phase
%prepare_figure();
figure
set(gcf,'paperunits','centimeters','Paperposition',[0 0 15 12])
%figure
%set(gcf,'paperunits','centimeters','Paperposition',[0 0 10 4])

axes('Position',[.1 .6 .86 .3])
hY = plot(f/1000,fftshift(abs(Y))/max(abs(Y)),'Color',cols(1,:))
xlim([-fs/2/1000 fs/2/1000])
title('magnitude')
xlabel('frequency / kHz')
ylabel('amplitude (normalized)')

axes('Position',[.1 .15 .86 .3])
hm = plot(f/1000,(fftshift((Y_phase))),'Color',cols(1,:))
xlim([-fs/2/1000 fs/2/1000])
title('phase')
xlabel('frequency / kHz')
ylabel('angle / \pi')

%cometics
set([hY hm],'Linewidth',2,'Markersize',6)

%saving
filename = '../pics/lecture_03_running_sum_tf_mag_phase.svg';
saveas(gcf, filename,'svg')
%save2pdf_and_crop(filename);
%savefig('../pics/lecture3_running_sum_tf_mag_phase', 'pdf');

%%%%%%%%%%%% order 10
%the IR
h = ones(10,1)/10; % 3rd order running sum

% define the signal
sig = [h(:); zeros(fs*T-length(h),1)];

%FFTinf
Y = fft(sig)/(fs*T);
%do a correction to get rid of rounding errors during FFT
%Y_corr = Y.*(abs(Y)>4*eps);
Y_phase = angle(Y)/(pi);


%plotting
%prepare_figure;
figure
set(gcf,'paperunits','centimeters','Paperposition',[0 0 15 12])
%set(gcf,'paperunits','centimeters','Paperposition',[0 0 10 4])

axes('Position',[.1 .6 .86 .3])
ht1 = stem(t*1000,sig,'Color',cols(1,:));
title('time signal (impulse response)')
xlabel('time / ms')
ylabel('amplitude / a.u.')
xlim([-1/fs T+1/fs]*1000)
ylim([0 1.1*max(sig)])

axes('Position',[.3 .7 .56 .15])
ht2 = stem([0:10],sig(1:11),'Color',cols(1,:));
ylim([0 1.1*max(sig)])
xlabel('sample nr.')
%ylabel('amplitude / a.u.')
xlim([-1 11])

axes('Position',[.1 .15 .86 .3])
hY = plot(f/1000,fftshift(abs(Y))/max(abs(Y)),'Color',cols(1,:))
xlim([-fs/2/1000 fs/2/1000])
title('magnitude (of transfer function)')
xlabel('frequency / kHz')
ylabel('amplitude (normalized)')

%cometics
set([ht1 ht2 hY],'Linewidth',2,'Markersize',6)

%saving
filename = '../pics/lecture_03_running_sum_tf10.svg';
saveas(gcf, filename,'svg')
%save2pdf_and_crop(filename);

%savefig('../pics/lecture3_running_sum_tf10', 'pdf');


%% magnitude and phase
figure
set(gcf,'paperunits','centimeters','Paperposition',[0 0 15 12])
%prepare_figure;
%set(gcf,'paperunits','centimeters','Paperposition',[0 0 10 4])

axes('Position',[.1 .6 .86 .3])
hY = plot(f/1000,fftshift(abs(Y))/max(abs(Y)),'Color',cols(1,:))
xlim([-fs/2/1000 fs/2/1000])
title('magnitude')
xlabel('frequency / kHz')
ylabel('amplitude (normalized)')

axes('Position',[.1 .15 .86 .3])
hm = plot(f/1000,(fftshift((Y_phase))),'Color',cols(1,:))
xlim([-fs/2/1000 fs/2/1000])
title('phase')
xlabel('frequency / kHz')
ylabel('angle / \pi')

%cometics
set([hY hm],'Linewidth',2,'Markersize',6)

%saving
filename = '../pics/lecture_03_running_sum_tf10_mag_phase.svg';
saveas(gcf, filename,'svg')
%save2pdf_and_crop(filename);
%savefig('../pics/lecture3_running_sum_tf10_mag_phase', 'pdf');
