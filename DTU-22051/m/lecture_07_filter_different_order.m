function lecture7_filter_different_order()
% Fucntion to demonstrate how filters with increasing order look like. The
% function does not take any input arguments, change parameters section if
% you want to see some different seetings/configurations

close all

%% some parameters
fs = 5000; % samplingrate
n = 1:1:20;   % filter orders
fc = 1000;
T = 1;      % length of impulse
imp = [1; zeros(T*fs-1,1)];

% some vectors used for plotting
t = 0:1/fs:1-1/fs;  % time
f = 0:1/T:fs/2;     % frequency
idx_pos = 1:length(f);% index for positive freqs

cols = [0 0 1; 1 0 0; 0 1 0]*.6;
lw = 1;
font_size = 12;

path2pic = ['..' filesep 'pics' filesep 'lecture_07-movie-filter-order_z' filesep];
file_pre = 'lecture_07_filter_order_z_';


%% Start with Butterworths
for k=1:length(n)
    close all
   [B,A] = butter(n(k), fc/fs);
        % for cheking the filters
        % freqz(B,A)   
        % ylim([-50 5])
        % pause
   
   % get the impulse response
   ir = filter(B,A,imp);
        % plot(ir)
        % xlim([0 200])
        % pause
    
   % and the TF
   TF = fft(ir);
   TF_mag = (abs(TF));
   TF_phase = unwrap(angle(TF))/(2*pi);

   
   % get the z-plane as "rubber membrane"
   [x, y, magnitude, x_uc, y_uc, magnitude_uc] = lecture_06_function_zplane_rubbermembrane(roots(B), roots(A));
    
%      
%    
%    
%    % plot TF magnitude and phase
%    %prepare_figure;
%    set(gcf,'Paperposition',[0 0 20 10]);
%    axes('Position',[.1 .1 .35 .85])
%    [ax h1 h2] = plotyy(f,TF_mag(idx_pos),f,TF_phase(idx_pos))
%    set(h1,'Linewidth',lw,'Color',cols(1,:),'Linewidth',lw);
%    set(h2,'Linewidth',lw,'Color',cols(3,:),'Linewidth',lw);
%    set(get(ax(1),'Ylabel'),'String','Gain (linear)','Color',cols(1,:));
%    set(get(ax(2),'Ylabel'),'String','Phase / 2\pi','Color',cols(3,:));
%    line([500 500],[0 1.1],'Color','k','Linestyle','--','Linewidth',lw)
%    xlabel('Frequency / Hz')   
%    % Set axis and stuff
%    axes(ax(1));
%    set(gca,'ylim',[0 1.1], 'ytick',[0:.1:1],'YColor',cols(1,:))
%    axes(ax(2));
%    set(gca,'ylim',[-5 .5],'ytick',[-5:1:0],'yticklabel',[-5:1:0])
% %   pause(.1)
%    title('Magnitude and phase')
% %    filename = [path2pic file_pre 'TF_phase_' num2str(n(k)) '.eps'];
% %    save2pdf_and_crop(filename);
%    
%    
%    % plot IR
%    %prepare_figure;
%    axes('Position',[.6 .1 .35 .85])
%    h = plot(t(1:500),ir(1:500),'Color',cols(1,:),'Linewidth',lw);
%    ylim([-.3 .3])
%    xlim([0 .03])
%    xlabel('Time / s')
%    ylabel('Amplitude / a.u.')
%    title('Impulse response')
% 
%    text(-.011, .3,['Order: n = ' num2str(n(k))]);
%    
%    filename = [path2pic file_pre 'TF_phase_ir_' num2str(n(k)) '.eps'];
%    save2pdf_and_crop(filename);
%    %set(h,)
%    
%    close all
   %% now LOG
    % plot TF magnitude and phase
   %prepare_figure;
   set(gcf,'Papersize',[20 8],'Paperposition',[0 0 20 8]);
   axes('Position',[.4 .15 .2 .75])
   [ax h1 h2] = plotyy(f,20*log10(TF_mag(idx_pos)),f,TF_phase(idx_pos))
   set(h1,'Linewidth',lw,'Color',cols(1,:),'Linewidth',lw);
   set(h2,'Linewidth',lw,'Color',cols(3,:),'Linewidth',lw);
   set(get(ax(1),'Ylabel'),'String','Gain / dB','Color',cols(1,:));
   set(get(ax(2),'Ylabel'),'String','Phase / 2\pi','Color',cols(3,:));
   line([500 500],[-60 1],'Color','k','Linestyle','--','Linewidth',lw)
   xlabel('Frequency / Hz')   
   % Set axis and stuff
   axes(ax(1));
   set(gca,'ylim',[-51 1], 'ytick',[-50:10:0],'YColor',cols(1,:))
   axes(ax(2));
   set(gca,'ylim',[-5 .5],'ytick',[-5:1:0],'yticklabel',[-5:1:0],'Ycolor',cols(3,:))
%   pause(.1)
   title('Magnitude and phase')
%    filename = [path2pic file_pre 'TF_phase_' num2str(n(k)) '.eps'];
%    save2pdf_and_crop(filename);
   
   
   % plot IR
   %prepare_figure;
   axes('Position',[.75 .15 .2 .75])
   h = plot(t(1:500),ir(1:500),'Color',cols(1,:),'Linewidth',lw);
   ylim([-.3 .3])
   xlim([0 .03])
   xlabel('Time / s')
   ylabel('Amplitude / a.u.')
   title('Impulse response')

   % label
   text(-.08, .35,['Order: n = ' num2str(n(k))]);
  
    
   % plot the rubber membrane and all poles/zeros
   axes('Position',[.1 .15 .2 .8])
   f2 = surf(x,y,magnitude*0);
   title('z-plane')
   set(f2,'Edgealpha',.1,'Facealpha',.1,'FaceColor',[.8 .8 .8],'Edgecolor',[.6 .6 .6])
   
   %% reference unit circle
   plot3(x_uc,y_uc,magnitude_uc*0,'Linewidth',2,'Color',[.7 .7 .7],'Linestyle',':')
   
   % axes
   line([-2 2], [0 0], [0 0],'Color',[.7 .7 .7],'Linewidth',2)
   line([0 0], [-2 2], [0 0],'Color',[.7 .7 .7],'Linewidth',2)
   
   xlabel('Re')
   ylabel('Im')
   zlabel('Gain / dB')
   
   %% plot poles and zeros
   zs = roots(B);
   ps = roots(A);
   
   hold on
   for kk = 1:length(zs)
       plot3(real(zs(kk)),imag(zs(kk)),0,'o','Markersize',5,'Markerfacecolor',[.7 .7 .7],'Color',[.7 .7 .7],'linewidth',2)   
   end
   for ll = 1:length(ps)
       plot3(real(ps(ll)),imag(ps(ll)),0,'x','Markersize',5,'Markerfacecolor',[.7 .7 .7],'Color',[.7 .7 .7],'linewidth',2)   
   end
     
   %plot3(real(z1),imag(z1),0,'o','Markersize',10,'Markerfacecolor',[.7 .7 .7],'Color',[.7 .7 .7],'linewidth',2)
   %plot3(real(z2),imag(z2),0,'o','Markersize',10,'Markerfacecolor',[.7 .7 .7],'Color',[.7 .7 .7],'linewidth',2)
   
   %plot3(real(p1),imag(p1),0,'x','Markersize',10,'Markerfacecolor',[.7 .7 .7],'Color',[.7 .7 .7],'linewidth',2)
   %plot3(real(p2),imag(p2),0,'x','Markersize',10,'Markerfacecolor',[.7 .7 .7],'Color',[.7 .7 .7],'linewidth',2)
   
   view(10,25)
   
   
   %% The transfer function
   f1 = surf(x,y,magnitude);
   set(f1,'Edgealpha',.1,'Facealpha',.8,'Edgecolor','none','Facecolor','interp')
   hold on;
   
   xlim([-1.5 1.5])
   ylim([-1.5 1.5])
   zlim([-100 100])
   
   set(gca,'Xtick',[-1 0 1],'Ytick',[-1 0 1])
   
   %% The unit circle
   
   plot3(x_uc,y_uc,magnitude_uc,'Linewidth',2,'Color','r')
 
   
   filename = [path2pic file_pre 'LOG_TF_phase_ir_' num2str(n(k)) '.pdf'];
   save2pdf_and_crop_res(filename,300);
   %set(h,)
   %if k==1
   %    return
   %end
    
end


close all;

