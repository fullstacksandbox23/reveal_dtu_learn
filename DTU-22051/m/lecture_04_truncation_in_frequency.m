close all;
clear all;
clc

% Fourier transform a square wave. Truncate the high-frequency components
% pointwise and IFFT. See how the time signal changes.

fs = 100;
T = 1;
t = 0:1/fs:T-1/fs;
length_squares = 24;
f = [0:1/T:fs/2 (-fs/2+1/T):1/T:-1/T];

nr_iterations = 45;


% the rect
rect = [zeros(fs*T/2-length_squares/2,1); ...
        ones(length_squares,1); 
        zeros(fs*T/2-length_squares/2,1)];

% the FFT
Y = fft(rect);

% plot once and then update data in loop
% markers and line width
marker_size = 4;
line_width = 1.2;
cols = ([0 0 .6; .6 0 0; 0 .6 0]);

f_width = .4;
f_height = .8;

figure
set(gcf,'paperunits','centimeters','Paperposition',[0 0 20 10])

axes('Position',[.1 .2 f_width f_height]);
htime = plot(t,rect,'Color',cols(1,:)); hold on;
htime_mod = plot(t,rect,'Color',cols(2,:));

ylim([1.5*[-max(rect) max(rect)]])

xlabel('time / s')
ylabel('amplitude / a.u.')

axes('Position',[.6 .2 f_width f_height]);
hfreq = stem(f,abs(Y),'Color',cols(1,:)); hold on;
hfreq_mod = stem(f,abs(Y),'Color',cols(2,:));

ylim(1.1*[0 max(abs(Y))])

xlabel('frequency / Hz')
ylabel('amplitude / a.u.')

set([htime hfreq htime_mod hfreq_mod],'Linewidth',line_width,'Markersize',marker_size);


Y = fftshift(Y);
% now loop through and cut always symmetrically samples
for k=1:nr_iterations
    Y_mod = [Y(1); zeros(k,1); Y(k+2:end-k); zeros(k,1);];
    sig_mod = ifft(ifftshift(Y_mod));
    set(htime_mod,'YData',sig_mod)
    set(hfreq_mod,'YData',ifftshift(abs(Y_mod)))
    %save into datafile
    filename = ['..' filesep 'pics' filesep ...
                'lecture4-movie-truncation-frequency-domain' filesep ...
                'lecture4-truncation-frequency_' num2str(k) '.eps'];
    save2pdf_and_crop(filename);  
end



    

