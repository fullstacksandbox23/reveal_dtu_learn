clear all
close all

% some (signal) paramaters
fs = 100;
T1 = .5;
T2 = .8;

t1 = 0:1/fs:T1;
t2 = 0:1/fs:T2;

delay_samples = 13;

lw = 1;
ms = 4;

cols = [0 0 .6; .6 0 0; 0 .6 0];

fw = 10;
fh = 7;

% non-matching

sig1 = [zeros(.4*T1*fs,1); ones(.2*T1*fs+1,1); zeros(.4*T1*fs,1)];
sig2 = [zeros(delay_samples,1); exp(-t2(1:end-delay_samples)/.02)'];


% convolution
len_conv = length(sig1)+length(sig2)-1;
t12 = 0:1/fs:len_conv/fs-1/fs;

sig12 = conv(sig1,sig2);

% FFTing
Y1 = fft(sig1);
Y2 = fft(sig2);
Y12 = fft(sig12);

f1 = 0:1/T1:fs/2;
f2 = 0:1/T2:fs/2;
f12 = 0:fs/len_conv:fs/2;

% plotting
prepare_figure_scale(fw,fh);
% time signals
ht12 = stem(t12,sig12,'Color',cols(3,:));hold on;
ht2 = stem(t2,sig2,'Color',cols(2,:));
ht1 = stem(t1,sig1,'Color',cols(1,:)); 

xlabel('time / s')
ylabel('amplitude / a.u.')

legend('x_1(n)\astx_2(n)','x_2(n)','x_1(n)')

set([ht1 ht2 ht12],'Linewidth',lw,'Markersize',ms);

filenamet = ['..' filesep 'pics' filesep ...
                'lecture_04_convolution_nonmatching_t.pdf'];
save2pdf_and_crop(filenamet);

filenamet_svg = ['..' filesep 'pics' filesep ...
                'lecture_04_convolution_nonmatching_t.svg'];
saveas(gcf, filenamet_svg);


% spectra
prepare_figure_scale(fw,fh);
hf1 = stem(f1,abs(Y1(1:length(f1))),'Color',cols(1,:)); hold on;
hf2 = stem(f2,abs(Y2(1:length(f2))),'Color',cols(2,:));
hf12 = stem(f12,abs(Y12(1:length(f12))),'Color',cols(3,:));

xlabel('frequency /  Hz')
ylabel('amplitude / a.u.')

legend('F(x_1(n)\astx_2(n))','X_2[\omega]','X_1[\omega]')

xlim([0 10])

% cosmetics and saving
set([hf1 hf2 hf12],'Linewidth',lw,'Markersize',ms);
filenamef = ['..' filesep 'pics' filesep ...
                'lecture_04_convolution_nonmatching_f.pdf'];            
save2pdf_and_crop(filenamef);

filenamef_svg = ['..' filesep 'pics' filesep ...
                'lecture_04_convolution_nonmatching_f.svg'];           
saveas(gcf, filenamef_svg);


% --- matching 
% zero-pad the signals
sig1_pad = [sig1(:); zeros(length(sig2)-1,1)];
sig2_pad = [sig2(:); zeros(length(sig1)-1,1)];

t_pad = 0:1/fs:length(sig1_pad)/fs-1/fs;

% FFTing
Y1_pad = fft(sig1_pad);
Y2_pad = fft(sig2_pad);
Y12_pad = Y1_pad.*Y2_pad;

sig12_pad = ifft(Y12_pad);

f_pad = 0:fs/length(sig1_pad):fs/2;
f12 = 0:fs/(length(sig12_pad)):fs/2;

prepare_figure_scale(fw,fh);
% time signals
ht12 = stem(t_pad,sig12_pad,'Color',cols(3,:));hold on;
ht2 = stem(t_pad,sig2_pad,'Color',cols(2,:));
ht1 = stem(t_pad,sig1_pad,'Color',cols(1,:)); 

ylim([0 3])

xlabel('time / s')
ylabel('amplitude / a.u.')

legend('x_1(n)\astx_2(n)','x_2(n) pad','x_1(n) pad')

set([ht1 ht2 ht12],'Linewidth',lw,'Markersize',ms);

filenamet = ['..' filesep 'pics' filesep ...
                'lecture_04_convolution_matching_t.pdf'];
save2pdf_and_crop(filenamet);

filenamet_svg = ['..' filesep 'pics' filesep ...
                'lecture_04_convolution_matching_t.svg'];
saveas(gcf, filenamet_svg);

% spectra 
prepare_figure_scale(fw,fh);
hf12 = stem(f_pad,abs(Y12_pad(1:length(f12))),'Color',cols(3,:)); hold on;
hf2 = stem(f_pad,abs(Y2_pad(1:length(f_pad))),'Color',cols(2,:));
hf1 = stem(f_pad,abs(Y1_pad(1:length(f_pad))),'Color',cols(1,:));

xlabel('frequency /  Hz')
ylabel('amplitude / a.u.')

legend('|X_1[\omega]X_2[\omega]|','|X_2[\omega]|','|X_1[\omega]|')


xlim([0 10])

% cosmetics and saving
set([hf1 hf2 hf12],'Linewidth',lw,'Markersize',ms);
filenamef = ['..' filesep 'pics' filesep ...
                'lecture_04_convolution_matching_f.pdf'];            
save2pdf_and_crop(filenamef);

filenamef_svg = ['..' filesep 'pics' filesep ...
                'lecture_04_convolution_matching_f.svg']; 
saveas(gcf, filenamef_svg);

