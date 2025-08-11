% Script to demonstrate why a convolution describes filtering in such a way
% We use a simple FIR filter for demonstration purposes

clear all;
close all;

% some parameters

% IR
T_max_s = 5;                    % max length of IR               
delays_s = [1000 200 10]*1e-3;  % delays in milliseconds for the three cases
alpha = .7;                     % attenuation coefficient

% Which sound file?
%sndfile = ['..', filesep, 'wav', filesep, 'lecture_01_mini-me_short.wav'];
sndfile = ['..', filesep, '..', filesep, '_library', filesep, ... 
    'wav', filesep, 'GlassBreak.wav'];
[y, fs_wav] = audioread(sndfile);
y = y(:);

% final .wav
fs_final = 44100;
path2wav = ['..', filesep, 'wav', filesep];
fname_pre = ['lecture_02_demo_audio_convolution_'];
fname_post = ['ms.wav'];

% final .png
path2pic = ['..', filesep, 'pics', filesep];
pic_post = ['ms.png'];

t_wav = 1/fs_wav:1/fs_wav:T_max_s;
t_out = 1/fs_final:1/fs_final:T_max_s; % a suitable time vector for plotting

% som eplotting stuff - hand-tweaked
xmax = [5, 1, 500e-3];

% the path to the files for export
path2files = ['..', filesep, 'pics', filesep];
fig_w = 9;
fig_h = 8;      % figure width/height in cm
lw = 1.5;       % line width

% create the IR and the filtered signals
IR = [1, zeros(1,fs_wav*T_max_s-1)];

for dd = 1:length(delays_s)
    % prepare the figure
    prepare_figure_scale(fig_w,fig_h)     % this is a self-written function to do figure cosmetics

    hold on;
    idx = delays_s(dd)*fs_wav+1; % the first reflection
    r = 1;                  % count reflections
    while idx < (fs_wav*T_max_s-fs_wav)
        IR(idx) = alpha^r;
        delta_idx = delays_s(dd)*fs_wav; 
        idx = idx+delta_idx;
        r = r+1;
    end
    snd = conv(y(:,1),IR); % process
    snd2out = snd/max(snd); % normalize
    
    % do we need to resample?
    if fs_wav ~= fs_final
        snd2out = resample(snd2out, fs_final, fs_wav);
    end

    % Wanna see /hear?
    % for plotting
    % find length to plot
    len2plot_wav = min(length(y), length(t_wav));
    len2plot_out = min(length(snd2out), length(t_out));
    
    plot(t_out(1:len2plot_out),snd2out(1:len2plot_out),'Color',[155 10 10]/255) % plot the processed sound
    % now add the individual contributions
    for d = 1:r
        delta_idx = (d-1)*delays_s(dd)*fs_wav;
        plot(t_wav(1:len2plot_wav)+delta_idx/fs_wav,y(1:len2plot_wav)/(max(y))*alpha^(d-1), ...
            'Color',[200, 200, 200]/255*(0.8^d),'LineStyle',':')
    end
    
    stem(t_wav,IR(1:length(t_wav)),'linewidth',lw,'Color',[10 10 155]/255); %plot the IR
    xlabel('time (s)')
    ylabel('amplitude ( a.u.)')
    
    % plotting cosmetics
    xlim([0 xmax(dd)])
    ylim([-1.05 1.05])

    % listen?
    sound((conv(y,IR)),44100)
    IR(2:end) = IR(2:end)*0; %reset IR

    % push out

    audiowrite([path2wav, fname_pre, num2str(delays_s(dd)*1000), ...
            fname_post],snd2out*.9,fs_final); % save to file

    saveas(gcf, [path2pic, fname_pre, num2str(delays_s(dd)*1000), ...
            pic_post],'png');
end