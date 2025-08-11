close all; clear all;

%% this script produces a visualization of the overlap/add algorithm

% some plotting/saving params
path2pics = ['..', filesep, 'pics', filesep];
lw = 2; % line width


% some intial parameters
fs = 500;
T_tot = 1;

% chunks
N_chunks = 5;
len_chunk = fix((T_tot/N_chunks)*fs);
len_h = len_chunk/2;

% now we can make the time vector we need
t = 0:1/fs:T_tot+len_h/fs-2/fs;
%t = 0:1/fs:T_tot-1/fs;


% the signal and filter
sig = randn(fs*T_tot,1);
sig = sig/max(sig)*.7;
% h = 1/20*ones(20,1);
h = exp(-t(1:fix(length(sig)/(N_chunks*2)))/(T_tot/10));


% now we want to plot the original signal on top and the IR below. Then we
% want to plot the signal chunks and the filtered chunks 
prepare_figure_scale(18,9)
plot(t(1:length(sig)),sig+8,'Linewidth',lw);
hold on;
plot(t(1:length(h)),h+6.5,'Linewidth',lw,'color',[.7 .2 .2])

% remove tics, add labels
set(gca,'Xtick',[],'Ytick',[])
xlabel('time')
ylabel('amplitude')
ylim([-1 9])
xlim([0 T_tot+length(h)/fs])

% now iterate through the chunks and plot with an offset
for kk=1:N_chunks
    % the signal chunk
    idx_start = 1+(kk-1)*fix(length(sig)/N_chunks);
    idx_stop = idx_start+len_chunk-1;
    plot(t(idx_start:idx_stop),sig(idx_start:idx_stop)+6.5-kk*1, ...
        'Color',[.7 .7 .7],'Linewidth',lw)
    % the processed chunk
    idx_stop_conv = idx_start + (len_chunk+length(h)-1)-1;
    plot(t(idx_start:idx_stop_conv),.25*conv(h,sig(idx_start:idx_stop))+6.5-kk*1, ...
        'Color',[.7 .4 .4],'Linewidth',lw)
    % add a vertical line
    line([t(idx_stop) t(idx_stop)],[-2 10], ...
        'Color',[.8 .8 .8],'Linestyle',':','Linewidth',lw)
end


% now plot the filtered and the convolved signals on top of each other
plot(t(1:length(sig)),filter(h,1,sig*.25),'Color',[.4 .4 .7],'Linewidth',lw);
plot(t,conv(h,sig)*.25,'Color',[.7 .4 .4],'Linewidth',.7*lw);

% export into a file
%fname = [path2pics, 'lecture_04_overlap_add_real.pdf'];
%save2pdf_and_crop(fname);
%saveas(gcf,fname,'pdf')

fname = [path2pics, 'lecture_04_overlap_add_real.svg'];
saveas(gcf,fname,'svg')
