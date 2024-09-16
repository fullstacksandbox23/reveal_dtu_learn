%% Script to visualize the effect of concatenating/windowing IRs

% clean up
clc
clear all;
close all;

fs = 1;

order = 80:-2:2;

% plotting stuff
x_offset = .1;
y_offset = .1;
width = (1-2*x_offset)/2.1;
height = (1-2*y_offset)/2.1;

lw = 1;
path2pics = ['..' filesep 'pics' filesep 'lecture8-movie-fir_windowing' filesep];


% the IR
k = -40:1/fs:40;
%unwindowed
h = sinc(k/3/pi);
idx_center = (length(h)-1)/2+1;
idx_t_pos = (length(h)-1)/2+1:length(h);
f=0:1/(length(h)):fs/2;
idx_f_pos = 1:length(f);

prepare_figure_scale(20,10)
a1 = axes('Position',[x_offset 2.1*y_offset+height 2*width+x_offset height]);
h10 = plot(k,h,'Color',[1 1 1]*.5); hold on;
h11 = stem(k,h,'Color',[0 0 .6]);
h12 = stem(k,h.*hann(length(h))','Color',[.6 0 0])
xlabel('sample number')
ylabel('amplitude / a.u.')
xlim([-20 20])
ylim([-.6 1.1])

legend('analogue','rect-win','Hann-win')
ht = text(-17,.7,'');


a2 = axes('Position',[x_offset y_offset width height*.9]);
Y_all = fft(h);
h20 = plot(f/max(f),20*log10(abs(Y_all(idx_f_pos))),'Color',[1 1 1]*.5); hold on;
h21 = stem(0,0,'Color',[0 0 .6]);
xlabel('frequency / normalized')
ylabel('amplitude / dB')
xlim([0 1])
ylim([-62 22])

a3 = axes('Position',[2*x_offset+width y_offset width height*.9]);
Y_all_hann = fft(h.*hann(length(h))');
h30 = plot(f/max(f),20*log10(abs(Y_all_hann(idx_f_pos))),'Color',[1 1 1]*.5); hold on;
h31 = stem(0,0,'Color',[.6 0 0]);
xlabel('frequency / normalized')
xlim([0 1])
ylim([-62 22])


set([h10 h11 h12 h20 h21 h30 h31],'Linewidth',lw)

%ylabel('amplitude / dB')

% rect windowing
for l=1:length(order)
    h_win = [zeros(1,idx_center-1-order(l)/2)  ...
                h(idx_center-order(l)/2:idx_center+order(l)/2) ...
                zeros(1,idx_center-1-order(l)/2)];
    h_hann = [zeros(1,idx_center-1-order(l)/2)  ...
                hann(length(h(idx_center-order(l)/2:idx_center+order(l)/2)))' ...
                .*h(idx_center-order(l)/2:idx_center+order(l)/2) ...
                zeros(1,idx_center-1-order(l)/2)];        
    Y_mag = 20*log10(abs(fft(h_win)));        
    Y_mag_hann = 20*log10(abs(fft(h_hann)));
    Y_ang = unwrap(angle((fft(h_win))));        
    set(h11,'xdata',k(idx_center-order(l)/2:idx_center+order(l)/2) ...
            ,'Ydata', h_win(idx_center-order(l)/2:idx_center+order(l)/2));
    set(h12,'xdata',k(idx_center-order(l)/2:idx_center+order(l)/2) ...
            ,'Ydata', h_hann(idx_center-order(l)/2:idx_center+order(l)/2));        
    %f = 0:1/(order(l)):fs/2;
    %idx_f_pos = 1:length(f);
    set(ht,'String',['order = ' num2str(order(l)+1)])
    set(h21,'xdata',f(idx_f_pos)/max(f),'Ydata',Y_mag(idx_f_pos))
    set(h31,'xdata',f(idx_f_pos)/max(f),'Ydata',Y_mag_hann(idx_f_pos))
    save2pdf_and_crop([path2pics 'lecture8_fir_windowing_' num2str(l) '.eps'])    
end
