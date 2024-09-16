clear all;
close all;

nr_steps = 50;
increment = 1/50;

% signal parameters
fs = 100;
T = 1;

t = 0:1/fs:T-1/fs;
f_pos = 0:1/T:fs/2;
f_all = [f_pos -f_pos(end-1:-1:2)];

% plotting stuff
cols = [0 0 .6; .6 0 0; 0 .6 0];
f_width = 8/20;
f_height = 8/10;
lw = 1;
ms = 4;

path2pic = ['..' filesep 'pics' filesep 'lecture_09-movie-zplane-tf-moving-zeros' filesep];


% set impulse response
%sig = [ones(1,order_rs) zeros(1,fs*T-order_rs)];


figure
set(gcf,'paperunits','centimeters','Paperposition',[0 0 20 10])

for k=1:nr_steps

% zero_s = [0 0; 0 0];
% zero_s_Z = [0; 0]; 
% poles = [-1/2 (increment*k); -1/2 -(increment*k)];
% poles_Z = [-1/2+j*(increment*k); -1/2-j*(increment*k)];
% 
% % get the impulse response
% %hsos = zp2sos(zero_s_Z,poles_Z,1);
% hsos = zp2sos(zero_s_Z, poles_Z,1);
% sig = [hsos(1:3) zeros(1,fs*T-3)];
% 
% imp = filter(1,poly(zero_s_Z'),[1; zeros(fs*T-1,1)]);


poles_s = [-1/2 sqrt(3)/2; -1/2 -sqrt(3)/2];
poles_Z = [-1/2+j*sqrt(3)/2; -1/2-j*sqrt(3)/2];
zeros = [.5*cos((increment*k)*(2*pi)) .5*sin((increment*k)*(2*pi)); ...
         .5*cos((increment*k)*(2*pi)) -.5*sin((increment*k)*(2*pi))];
zero_s_Z = [.5*cos((increment*k)*(2*pi))+j*.5*sin((increment*k)*(2*pi)); ...
         .5*cos((increment*k)*(2*pi))-j*.5*sin((increment*k)*(2*pi))];

% get the impulse response
hsos = zp2sos(zero_s_Z,poles_Z,1)
h = impz(hsos(1:3), hsos(4:end))
sig = [h' zeros(1,fs*T-length(h))];
%sig(1:4)

% get transfer function of running sum
Y = fft(sig);
Y_mag = 20*log10(abs(Y)/max(abs(Y)));

xpos = cos(2*pi*f_all/fs);
ypos = sin(2*pi*f_all/fs);





% %sig(1:4)
% 
% % get transfer function of running sum
% Y = fft(imp);
% Y_mag = 20*log10(abs(Y)/max(abs(Y)));
% 
% xpos = cos(2*pi*f_all/fs);
% ypos = sin(2*pi*f_all/fs);


    if k==1
        

    axes('Position',[.1 .1+f_height*(1+.5-1/3)/2 f_width f_height/3])
    %axis square
    himp = stem(t,imp,'o','Color',cols(1,:));
    %hYp = plot(f_all(k)/max(f_all),Y_mag(k),'s','Color',cols(2,:),'Markerfacecolor',cols(2,:))
    
    xlabel('Time / s')
    ylabel('Amplitude / a.u.')
    
    xlim([0 .5])
    ylim([-2.1 2.1])
    
    title('Impulse response')
    
    axes('Position',[.1 .1 f_width f_height/3])
    %axis square
    hY = stem(f_all/max(f_all),Y_mag(1:length(f_all)),'o','Color',cols(1,:)); hold on
    %hYp = plot(f_all(k)/max(f_all),Y_mag(k),'s','Color',cols(2,:),'Markerfacecolor',cols(2,:))
    
    xlabel('frequency (normalized) / \pi')
    ylabel('magnitude (normalized) / dB')
    
    xlim([-1 1])
    ylim([-43 3])
    
    title('Frequency transfer function')
     
    
    axes('Position',[.18+f_width .1 f_width f_height])
    axis square
    hpz = plot(xpos,ypos,'Color',cols(1,:)); hold on;
    %hpzp = plot(xpos(k),ypos(k),'s','Color',cols(2,:),'Markerfacecolor',cols(2,:));

    xlim([-1.1 1.1])
    ylim([-1.1 1.1])
    
    hpo1 = plot(poles(1,1),poles(1,2),'o','Markersize',2*ms,'Color',cols(3,:),'Markerfacecolor',cols(3,:));
    hpo2 = plot(poles(2,1),poles(2,2),'o','Markersize',2*ms,'Color',cols(3,:),'Markerfacecolor',cols(3,:));
    hz1 = plot(zero_s(1,1),zero_s(1,2),'x','Markersize',2*ms,'Color',cols(3,:),'Markerfacecolor',cols(3,:)),
    hz2 = plot(zero_s(1,1),zero_s(2,2),'x','Markersize',2*ms,'Color',cols(3,:),'Markerfacecolor',cols(3,:));
    
    %hlp = line([0 xpos(k)],[0 ypos(k)],'Color',cols(2,:),'Linewidth',lw)
    hl1 = line([0 0],[-1 1],'Color','k')
    hl2 = line([-1 1],[0 0],'Color','k')
    
    xlabel('Re')
    ylabel('Im')
    
    title('z-plane')
    
    set([hY hl1 hl2 himp],'Linewidth',lw,'Markersize',ms);    
    %set([hYp hpz],'Linewidth',1.5*lw,'Markersize',1.5*ms);
      
    else
    %set(hYp,'Xdata',f_all(k)/max(f_all),'Ydata',Y_mag(k));
    %set(hpzp,'Xdata',xpos(k),'Ydata',ypos(k));
    %set(hlp,'Xdata',[0 xpos(k)],'Ydata',[0 ypos(k)]);
    set(himp,'Xdata',t,'Ydata',imp)
    set(hY,'Ydata',Y_mag(1:length(f_all)))
    set(hz1,'Xdata',zero_s(1,1),'Ydata',zero_s(1,2));
    set(hz2,'Xdata',zero_s(2,1),'Ydata',zero_s(2,2));
    set(hpo1,'Xdata',poles(1,1),'Ydata',poles(1,2));
    set(hpo2,'Xdata',poles(2,1),'Ydata',poles(2,2));
    end
    
    %filename = [path2pic 'lecture_09_zplane_tf_movingzeros_frame_' num2str(k) '.eps'];
    %save2pdf_and_crop(filename);
%    pause(.2)
end


%plot(xpos,ypos,'o')