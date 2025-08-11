function lecture_10_chirps()
% Fucntion to plot pictures re chirps and the analysis in frequency and
% time.
%
% Function call:
%
%   >> lecture10_chirps()

close all
clc

% some parameters etc
fs = 1000;
T = 1;
t = 0:1/fs:T-1/fs;
f = 0:1/T:fs/2;
idx_pos = 1:length(f);

f_begin = 1;
f_end = 50;

win_width_samples = 200;
win = hamming(win_width_samples);
win_initial = [win; zeros(fs*T-win_width_samples,1)];

% number of stepos window is put forward
nr_steps = 100;
delta_sample = fix((T*fs-win_width_samples) / nr_steps);

% plotting stuff
cols = [0 0 .6; .6 0 0; 0 .6 0];

x_margin = .15;
f_width = 1-x_margin-.05;
y_margin = .1;

lw = 1;

path2fig = ['..' filesep 'pics' filesep];
%path2fig = ['pics' filesep];
path2mov = ['lecture_10_movie_sliding_window' filesep];


% make a chirp
sig = chirp(t,f_begin,T,f_end,'Linear');


% plot the chirp only
prepare_figure_scale(15,10)
h1 = plot(t,sig,'Color',cols(1,:),'Linewidth',lw);

ylim([-1.1 1.1])

xlabel('Time / s')
ylabel('Amplitude / a.u.')

filename = [path2fig 'lecture_10_chirp_only.pdf'];
save2pdf_and_crop(filename)

set([h1],'Linewidth',lw);


% chirp windowed
prepare_figure_scale(15,10)
for k = 1:nr_steps
    if k==1
        h1 = plot(t,sig,'Color',[.8 .8 .8],'Linewidth',lw); hold on;
        hw = plot(t,win_initial','Color',[.4 .4 .4],'Linewidth',lw); 
        h2 = plot(t,sig.*win_initial','Color',cols(1,:),'Linewidth',lw)
        ylim([-1.1 1.1])
        xlabel('Time / s')
        ylabel('Amplitude / a.u.')
        legend({'signal','window function','windowed signal'})
    else
        set(hw,'Ydata',circshift(win_initial,delta_sample*k)');    
        set(h2,'Ydata',sig.*circshift(win_initial,delta_sample*k)');    
    end
    filename = [path2fig path2mov 'lecture_10_chirp_windowed_frame_' num2str(k) '.pdf'];
    save2pdf_and_crop(filename)
    
    set([h2],'Linewidth',lw);
end



% now the brute-force spectrogram
prepare_figure_scale(15,10)

S = zeros(length(sig),nr_steps);

%figure()

axes('Position',[x_margin y_margin+.05 f_width .2]);
ht = plot(t,sig.*win_initial','Color',cols(1,:),'Linewidth',lw);
ylim([-1.1 1.1])
xlabel('Time / s')
ylabel('Amplitude / a.u.')

S(:,1) = 20*log10(abs(fft(sig.*win_initial')));
f = 0:1/T:fs/2;
idx_pos = 1:length(f);

axes('Position',[x_margin y_margin+.4 f_width .45]);
hf = plot(f,S(idx_pos,1),'Color',cols(1,:),'Linewidth',lw);
xlim([0 1.5*f_end])
ylim([max(S(idx_pos,1))-85 max(S(idx_pos,1))+5])
xlabel('Frequency / Hz')
ylabel('Amplitude / dB')



for k = 2:nr_steps
    set(ht,'Ydata',sig.*circshift(win_initial,delta_sample*k)');
    S(:,k) = 20*log10(abs(fft(sig.*circshift(win_initial,delta_sample*k)')));
    set(hf,'Ydata',S(idx_pos,k));
    
    filename = [path2fig path2mov 'lecture_10_chirp_windowed_spectrum_frame_' num2str(k) '.pdf'];
    save2pdf_and_crop(filename)
    
    set([h2],'Linewidth',lw);
    %pause(.1)
end

prepare_figure_scale(15,10)
%figure
imagesc(S(idx_pos,:)); hold on
xlabel('Time step')
ylabel('Frequency / Hz')

filename = [path2fig 'lecture_10_chirp_windowed_specgram.pdf'];
save2pdf_and_crop(filename);


hl1 = line([0 100],[25 25]);

set([hl1],'Color','k','Linewidth',2);
filename = [path2fig 'lecture_10_chirp_windowed_specgram_horzcut.pdf'];
save2pdf_and_crop(filename);

set([hl1],'Xdata',[50 50],'Ydata',[0 1000]);
filename = [path2fig 'lecture_10_chirp_windowed_specgram_vetcut.pdf'];
save2pdf_and_crop(filename);



%eof
end