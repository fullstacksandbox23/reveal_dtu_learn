%% Script to generate and plot a couple of window functions

% clean up
clear all;
close all;

fs = 500;
length_window = 1;
T = 50;
t = 0:1/fs:T-1/fs;
f = 0:1/T:fs/2;
idx_pos = (1:length(f));

% color stuff
lw = 1;
path2pic = ['..' filesep 'pics' filesep];
filename_time_pre = [path2pic 'lecture_08_windows_time'];
filename_freq_pre = [path2pic 'lecture_08_windows_freq'];

%% time domain
% generate different window functions
w_rect = [zeros((.1*length_window)*fs,1); ones(length_window*fs,1); zeros((T-1.1*length_window)*fs,1)];
w_bart = [zeros((.1*length_window)*fs,1);bartlett(length_window*fs); zeros((T-1.1*length_window)*fs,1)];
w_hann = [zeros((.1*length_window)*fs,1);hann(length_window*fs); zeros((T-1.1*length_window)*fs,1)];
w_hamm = [zeros((.1*length_window)*fs,1);hamming(length_window*fs); zeros((T-1.1*length_window)*fs,1)];
w_black = [zeros((.1*length_window)*fs,1);blackman(length_window*fs); zeros((T-1.1*length_window)*fs,1)];
w_kaiser = [zeros((.1*length_window)*fs,1);kaiser(length_window*fs); zeros((T-1.1*length_window)*fs,1)];

%% frequency domain;
Y_rect = 20*log10(abs(fft(w_rect)));
Y_bart = 20*log10(abs(fft(w_bart)));
Y_hann = 20*log10(abs(fft(w_hann)));
Y_hamm = 20*log10(abs(fft(w_hamm)));
Y_black = 20*log10(abs(fft(w_black)));
Y_kaiser = 20*log10(abs(fft(w_kaiser)));


%% time domain

% RECT
prepare_figure_scale(12,8)
h1 = plot(t,w_rect,'Linewidth',lw,'Color',[0 0 .5]); hold on;
legend('rect')
xlabel('Time / s')
ylabel('Amplitude')
xlim([-.05 2.2])
ylim([0 1.1])
save2pdf_and_crop([filename_time_pre, '_rect.pdf']);



% RECT + Bartlett
prepare_figure_scale(12,8)
h1 = plot(t,w_rect,'Linewidth',lw,'Color',[0 0 .5]); hold on;
h2 = plot(t,w_bart,'Linewidth',lw,'Color',[0 0 .8]);

legend('rect','Bartlett')
xlabel('Time / s')
ylabel('Amplitude')
xlim([-.05 2.2])
ylim([0 1.1])
save2pdf_and_crop([filename_time_pre, '_bart.pdf']);


% RECT + Hann
prepare_figure_scale(12,8)
h1 = plot(t,w_rect,'Linewidth',lw,'Color',[0 0 .5]); hold on;
h3 = plot(t,w_hann,'Linewidth',lw,'Color',[0 .5 0]);

legend('rect','Hann')
xlabel('Time / s')
ylabel('Amplitude')
xlim([-.05 2.2])
ylim([0 1.1])
save2pdf_and_crop([filename_time_pre, '_hann.pdf']);


% RECT + Hamming
prepare_figure_scale(12,8)
h1 = plot(t,w_rect,'Linewidth',lw,'Color',[0 0 .5]); hold on;
h4 = plot(t,w_hamm,'Linewidth',lw,'Color',[0 .8 0]);

legend('rect','Hamming')
xlabel('Time / s')
ylabel('Amplitude')
xlim([-.05 2.2])
ylim([0 1.1])
save2pdf_and_crop([filename_time_pre, '_hamm.pdf']);

% RECT + Blackman
prepare_figure_scale(12,8)
h1 = plot(t,w_rect,'Linewidth',lw,'Color',[0 0 .5]); hold on;
h5 = plot(t,w_black,'Linewidth',lw,'Color',[.5 0 0]);

legend('rect','Blackman')
xlabel('Time / s')
ylabel('Amplitude')
xlim([-.05 2.2])
ylim([0 1.1])
save2pdf_and_crop([filename_time_pre, '_black.pdf']);


% RECT + Kaiser
prepare_figure_scale(12,8)
h1 = plot(t,w_rect,'Linewidth',lw,'Color',[0 0 .5]); hold on;
h6 = plot(t,w_kaiser,'Linewidth',lw,'Color',[.8 0 0]);

legend('rect','Kaiser')
xlabel('Time / s')
ylabel('Amplitude')
xlim([-.05 2.2])
ylim([0 1.1])
save2pdf_and_crop([filename_time_pre, '_kaiser.pdf']);


%% frequency domain

% RECT
prepare_figure_scale(12,8)
plot(f,Y_rect(idx_pos),'Linewidth',lw,'Color',[0 0 .5]); hold on;
legend('rect','Bartlett','Hann','Hamming','Blackman','Kaiser')
xlabel('Frequency / Hz')
ylabel('Magnitude')
xlim([0 20])
ylim([-52 57])
save2pdf_and_crop([filename_freq_pre, '_rect.pdf']);


% BARTLETT
prepare_figure_scale(12,8)
plot(f,Y_rect(idx_pos),'Linewidth',lw,'Color',[0 0 .5]); hold on;
h2 = plot(f,Y_bart(idx_pos),'Linewidth',lw,'Color',[0 0 .8]);
legend('rect','Bartlett')
xlabel('Frequency / Hz')
ylabel('Magnitude')
xlim([0 20])
ylim([-52 57])
save2pdf_and_crop([filename_freq_pre, '_bart.pdf']);

% HANN
prepare_figure_scale(12,8)
plot(f,Y_rect(idx_pos),'Linewidth',lw,'Color',[0 0 .5]); hold on;
h3 = plot(f,Y_hann(idx_pos),'Linewidth',lw,'Color',[0 .5 0]);
legend('rect','Hann')
xlabel('Frequency / Hz')
ylabel('Magnitude')
xlim([0 20])
ylim([-52 57])
save2pdf_and_crop([filename_freq_pre, '_hann.pdf']);

% HAMMING
prepare_figure_scale(12,8)
plot(f,Y_rect(idx_pos),'Linewidth',lw,'Color',[0 0 .5]); hold on;
h4 = plot(f,Y_hamm(idx_pos),'Linewidth',lw,'Color',[0 .8 0]);
legend('rect','Hamming')
xlabel('Frequency / Hz')
ylabel('Magnitude')
xlim([0 20])
ylim([-52 57])
save2pdf_and_crop([filename_freq_pre, '_hamm.pdf']);


% BLACKMAN
prepare_figure_scale(12,8)
plot(f,Y_rect(idx_pos),'Linewidth',lw,'Color',[0 0 .5]); hold on;
h5 = plot(f,Y_black(idx_pos),'Linewidth',lw,'Color',[.5 0 0]);
legend('rect','Blackman')
xlabel('Frequency / Hz')
ylabel('Magnitude')
xlim([0 20])
ylim([-52 57])
save2pdf_and_crop([filename_freq_pre, '_black.pdf']);


% KAISER
prepare_figure_scale(12,8)
plot(f,Y_rect(idx_pos),'Linewidth',lw,'Color',[0 0 .5]); hold on;
h6 = plot(f,Y_kaiser(idx_pos),'Linewidth',lw,'Color',[.8 0 0]);
legend('rect','Kaiser')
xlabel('Frequency / Hz')
ylabel('Magnitude')
xlim([0 20])
ylim([-52 57])
save2pdf_and_crop([filename_freq_pre, '_kaiser.pdf']);

close all


