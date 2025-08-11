close all;
clear all;
clc

% signal from wav file
[sig1, fs1] = audioread(['..' filesep 'wav' filesep 'lecture_01_railroad.wav']);
T1 = length(sig1)/fs1;
t1 = (0:1:length(sig1)-1)/fs1;

% signal generated artificially
fs2 = 100;
T2 = 1;
t2 = 0:1/fs2:T2-1/fs2;
sig2 = sin(2*pi*12*t2).*exp(-t2/.3);
%sig2 = 0.01.^t2;

% plotting parameters
line_width = 1;
marker_size = 4;
font_size = 12;
cols = ([0 0 .6; .6 0 0; 0 .6 0]);

%plotting
figure
set(gcf,'paperunits','centimeters','Paperposition',[0 0 10 6])

h1 = plot(t1,sig1);
set(h1,'Linewidth',line_width,'MArkersize',marker_size,'Color',cols(1,:))

xlim([0 T1])
ylim(1.1*[-max(sig1) max(sig1)])

xlabel('time / s')
ylabel('amplitude / a.u.')

%filename = '../pics/lecture_04_signal_finite.eps';
%save2pdf_and_crop(filename);

filename = '../pics/lecture_04_signal_finite.svg';
saveas(gcf, filename, 'svg')



%plotting
figure
set(gcf,'paperunits','centimeters','Paperposition',[0 0 10 6])

h2 = stem(t2,sig2);
set(h2,'Linewidth',line_width,'MArkersize',marker_size,'Color',cols(1,:))

xlim([0 T2])
ylim(1.1*[-max(sig2) max(sig2)])

xlabel('time / s')
ylabel('amplitude / a.u.')

%filename = '../pics/lecture_04_signal_infinite.eps';
%save2pdf_and_crop(filename);
filename = '../pics/lecture_04_signal_infinite.svg';
saveas(gcf, filename, 'svg')


%% fft of sig 2
Y_all = fft(sig2)/length(sig2);

w = [ones(1,length(sig2)/2) zeros(1,length(sig2)/2)];

%sig_part = [sig2(1:end-length(sig2)/2) zeros(1,length(sig2)/2)];
sig_part = sig2.*w;

Y_part = fft(sig_part)/length(sig_part);
Y_win = fft(w)/length(w);

f_all = 0:1/T2:fs2/2;

% plot with cut signal
figure
set(gcf,'paperunits','centimeters','Paperposition',[0 0 10 6])

hfull = stem(t2,sig2,'Color',cols(1,:)); hold on;
hpart = stem(t2,sig_part,'Color',cols(2,:))

xlim([0 T1])
ylim(1.1*[-max(sig2) max(sig2)])

xlabel('time / s')
ylabel('amplitude / a.u.')

legend('full','cut')

set([hfull hpart ],'Linewidth',line_width,'MArkersize',marker_size)

%filename = '../pics/lecture_04_signal_infinite_cut.eps';
%save2pdf_and_crop(filename);
filename = '../pics/lecture_04_signal_infinite_cut.svg';
saveas(gcf, filename, 'svg')



% plot with window
figure
set(gcf,'paperunits','centimeters','Paperposition',[0 0 10 6])

hfull = stem(t2,sig2,'Color',cols(1,:)); hold on;
hpart = stem(t2,sig_part,'Color',cols(2,:));
hwin = plot(t2,w,'k')

xlim([0 T1])
ylim(1.1*[-max(sig2) max(sig2)])

xlabel('time / s')
ylabel('amplitude / a.u.')

legend('cut','window')

set([hfull hwin hpart],'Linewidth',line_width,'MArkersize',marker_size)

%filename = '../pics/lecture_04_signal_infinite_cut_window.eps';
%save2pdf_and_crop(filename);
filename = '../pics/lecture_04_signal_infinite_cut_window.svg';
saveas(gcf, filename, 'svg')


% spectra
figure
set(gcf,'paperunits','centimeters','Paperposition',[0 0 10 6])

hs11 = stem(f_all,(abs(Y_all(1:length(f_all)))),'Color',cols(1,:)); hold on;
hs21 = stem(f_all,(abs(Y_part(1:length(f_all)))),'Color',cols(2,:));
hs12 = plot(f_all,(abs(Y_all(1:length(f_all)))),'Color',cols(1,:));
hs22 = plot(f_all,(abs(Y_part(1:length(f_all)))),'Color',cols(2,:));

set([hs11 hs21 hs12 hs22],'Linewidth',line_width,'MArkersize',marker_size)

legend('full','cut')
xlabel('frequency / Hz')
ylabel('amplitude / a.u.')

xlim([0 24])

%filename = '../pics/lecture_04_signal_infinite_spectrum.eps';
%save2pdf_and_crop(filename);
filename = '../pics/lecture_04_signal_infinite_spectrum.svg';
saveas(gcf, filename, 'svg')


% --- zero padding ---
% only half the length
sig_part_1 = sig_part(1:length(sig_part)/2);
% double the length
sig_part_2 = [sig_part zeros(1,5*length(sig_part))];

% FFTs
% short
Y_part_1 = fft(sig_part_1);%/length(sig_part_1);
f_part_1 = f_all(1:2:end);
%long
Y_part_2 = fft(sig_part_2);%/length(sig_part_2);
T_part_2 = length(sig_part_2)/fs2;
t_part_2 = 0:1/fs2:T_part_2-1/fs2;
f_part_2 = 0:1/T_part_2:fs2/2;

%normalizing
%Y_part_1 = Y_part_1/(max(abs(Y_part_1)));
%Y_part_2 = Y_part_2/(max(abs(Y_part_2)));


figure
set(gcf,'paperunits','centimeters','Paperposition',[0 0 10 6])

h1 = stem(f_part_1,abs(Y_part_1(1:length(f_part_1))),'Color',cols(1,:));

set([h1],'Linewidth',line_width,'MArkersize',marker_size)

legend('cut')

xlabel('frequency / Hz')
ylabel('amplitude / a.u.')

%filename = '../pics/lecture_04_signal_infinite_spectrum_cut.eps';
%save2pdf_and_crop(filename);
filename = '../pics/lecture_04_signal_infinite_spectrum_cut.svg';
saveas(gcf, filename, 'svg')



% spectra
figure
set(gcf,'paperunits','centimeters','Paperposition',[0 0 10 6])

h2 = stem(f_part_2,abs(Y_part_2(1:length(f_part_2))),'Color',cols(2,:));hold on;
h1 = stem(f_part_1,abs(Y_part_1(1:length(f_part_1))),'Color',cols(1,:));

set([h1 h2],'Linewidth',line_width,'MArkersize',marker_size)

legend('zero-pad','cut')

xlabel('frequency / Hz')
ylabel('amplitude / a.u.')

%filename = '../pics/lecture_04_signal_infinite_spectrum_cut_padded.eps';
%save2pdf_and_crop(filename);
filename = '../pics/lecture_04_signal_infinite_spectrum_cut_padded.svg';
saveas(gcf, filename, 'svg')

