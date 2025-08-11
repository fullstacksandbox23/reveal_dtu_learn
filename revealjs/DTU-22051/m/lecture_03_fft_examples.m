close all
%% Lecture 3: Some spectra and visualization of the FFT done in Matlab.

%% parameters
%sampling frequency
fs = 200;
f1 = 10;
T = 1;
t = 0:1/fs:T-1/fs;

delta_f = 1/T;
f = [-fs/2:delta_f:fs/2-delta_f];

n_neg = 1:length(f)/2+1;
n_pos = length(f)/2+1:length(f);

phases = linspace(0,2*pi,100);

ymax = 0.6;

%% plotting
%prepare_figure()
fig=figure();
set(gcf,'paperunits','centimeters','Paperposition',[0 0 15 12], 'Color', 'white')
set(gca,'Fontsize',14,'visible','off')
%hold on;

% plotting stuff
cols = [0 0 .6; .6 0 0; 0 .6 0];


% markers and line width
msize = 6;
lwidth = 1.2;

f_height = .6*1/3;

%% actual stuff
% let's generate, FFT and plot a sinusoidal signal that continuously shifts
% in phase.




for k = 1:length(phases)
    sig = sin(2*pi*f1*t+phases(k));% + sin(2*pi*5*f1*t+phases(k));
    Y = fft(sig)/(fs*T);
    Y_real = fftshift(real(Y));
    Y_imag = fftshift(imag(Y));
    Y_mag = fftshift(abs(Y));
    Y_angle = fftshift(unwrap(angle(Y))/(2*pi));
    Y_max = max(abs(Y));
    if k==1
        axes('Position',[.1 .1+2/3 .86 f_height])
        ht1 = stem(t,sig,'Color',cols(1,:));hold on;
        ht2 = plot(t,sig,'Color',cols(1,:));
        xlabel('t / samples')
        ylabel('amplitude / a.u.')
        title('time signal')
        ylim([-1.1 1.1])
        
        
        axes('Position',[.10 .1+1/3 .38 f_height])
        hr1 = stem(f(n_neg),Y_real(n_neg),'Color',cols(1,:)); hold on;
        hr2 = stem(f(n_pos),Y_real(n_pos),'Color',cols(2,:));
        xlabel('frequency / Hz')
        ylabel('amplitude / a.u.')
        title('real part')
        ylim([-ymax ymax])
        
        axes('Position',[.6 .1+1/3 .38 f_height])
        hi1 = stem(f(n_neg),Y_imag(n_neg),'Color',cols(1,:)); hold on;
        hi2 = stem(f(n_pos),Y_imag(n_pos),'Color',cols(2,:));
        xlabel('frequency / Hz')
        ylabel('amplitude / a.u.')
        title('imaginary part')
        ylim([-ymax ymax])        
        
        axes('Position',[.1 .1 .38 f_height])
        %hm1 = stem(f(n_neg),20*log10(Y_mag(n_neg))); hold on;
        %hm2 = stem(f(n_pos),20*log10(Y_mag(n_pos)),'r');
        hm1 = plot(f(n_neg),20*log10(Y_mag(n_neg)),'o-','Color',cols(1,:)); hold on;
        hm2 = plot(f(n_pos),20*log10(Y_mag(n_pos)),'o-','Color',cols(2,:));
        xlabel('frequency / Hz')
        ylabel('amplitude / dB')
        title('magnitude spectrum')
        ylim([-350 20*log10(ymax)+50])
        
        axes('Position',[.7 .1 f_height f_height])
        % hp = stem(f,Y_angle);
        % as phasors
        hp1 = plot(Y_real(n_neg)/Y_max,Y_imag(n_neg)/Y_max,'-o','Color',cols(1,:));hold on;
        hp2 = plot(Y_real(n_pos)/Y_max,Y_imag(n_pos)/Y_max,'-o','Color',cols(2,:));
        xlim([-1.1 1.1])
        ylim([-1.1 1.1])
        xlabel('Re')
        ylabel('Im')
        title('phase')        
        grid on;
        hold off
        
        set([ht1 ht2 hr1 hr2 hi1 hi2 hm1 hm2 hp1 hp2],'Linewidth',lwidth, ...
            'Markersize',msize);
        
        filename = ['../pics/lecture_03-movie-fft-examples/lecture_03-fft-example-frame-' num2str(k) '.eps'];
        %save2pdf_and_crop(filename);
        %savefig(['../pics/lecture3-movie-fft-examples/lecture3-fft-example-frame-' num2str(k)], ...
        %        'pdf');

        % GIF
        filename_gif = ['../pics/lecture_03-movie-fft-examples/lecture_03-fft-example.gif'];
        drawnow
        frame = getframe(fig);
        im{1} = frame2im(frame);
        

    else
        set(ht1,'Ydata',sig);
        set(hr1,'Ydata',Y_real(n_neg));
        set(hr2,'Ydata',Y_real(n_pos));
        set(hi1,'Ydata',Y_imag(n_neg));
        set(hi2,'Ydata',Y_imag(n_pos));
        set(hm1,'Ydata',20*log10(Y_mag(n_neg)));
        set(hm2,'Ydata',20*log10(Y_mag(n_pos)));
        %set(hp,'Ydata',Y_angle);        
        % phasors
        set(hp1,'XData',Y_real(n_neg)/Y_max,'Ydata',Y_imag(n_neg)/Y_max);        
        set(hp2,'XData',Y_real(n_pos)/Y_max,'Ydata',Y_imag(n_pos)/Y_max);
         filename = ['../pics/lecture3-movie-fft-examples/lecture3-fft-example-frame-' num2str(k) '.eps'];
        %save2pdf_and_crop(filename);
         
        %savefig(['../pics/lecture3-movie-fft-examples/lecture3-fft-example-frame-' num2str(k)], ...
         %       'pdf');

       % GIF
       frame = getframe(fig);
       im{k}= frame2im(frame);
       % -------------------------------
    end     
end



% GIF-ing
for idx = 1:length(phases)
    [A, map] = rgb2ind(im{idx},256);
    if idx == 1
        imwrite(A, map, filename_gif, "gif", "LoopCount", Inf, "DelayTime", .1);
    else
        imwrite(A, map, filename_gif, "gif", "Writemode", "append", "Delaytime",.1);
    end
end