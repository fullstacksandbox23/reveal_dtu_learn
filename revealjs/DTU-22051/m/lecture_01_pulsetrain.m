%function lecture1_explain_pulsetrain
% this function generates a nice movie to explain how the sum of complex
% exponentials leads to a train of delta-distributions

close all

% parameters
f_fundamental = 0.2;
nr_components = 5;

fs = 15;

T = 1/f_fundamental*2; % overall duration / s

% colors for plotting
cols = [0 0 .9; 0 0 .75; 0 0 .6; 0 0 .45; 0 0 .3; .6 0 0];
delta = .03;

% we want to have <nr_components> small plots where the phasors are rotating and a
% long plot which shows the single signals (sinusoids) and the sum of all.

f = (1:nr_components).'*f_fundamental;  % frequency vector
t = 0:1/fs:T-1/fs;

sig_real = cos(2*pi*f*t);
sig_imag = sin(2*pi*f*t);

sum_real = sum(sig_real,1);

%plotting
%prepare_figure();
figure
set(gcf,'paperunits','centimeters','Paperposition',[0 0 15 9])
set(gca,'Fontsize',14,'visible','off')

axes('Position',[.1 2/3 .15 1/4])
ht1 = plot(sig_real(1,1),sig_imag(1,1),'o','Color',cols(1,:),'Linewidth',1);
hl1 = line([0 sig_real(1,1)],[0 sig_imag(1,1)],'Linewidth',1,'Color',cols(1,:)) 
xlim([-1.05 1.05])
ylim([-1.05 1.05])
title('n=1')
xlabel('real','Fontsize',14)
ylabel('imag','Fontsize',14)
grid on

axes('Position',[.25+delta 2/3 .15 1/4])
ht2 = plot(sig_real(2,1),sig_imag(2,1),'o','Color',cols(2,:),'Linewidth',1);
hl2 = line([0 sig_real(1,1)],[0 sig_imag(1,1)],'Linewidth',1,'Color',cols(2,:)) 
xlim([-1.05 1.05])
ylim([-1.05 1.05])
title('n=2')
xlabel('real','Fontsize',14)
%ylabel('imag')
grid on

axes('Position',[.4+2*delta 2/3 .15 1/4])
ht3 = plot(sig_real(3,1),sig_imag(3,1),'o','Color',cols(3,:),'Linewidth',1);
hl3 = line([0 sig_real(1,1)],[0 sig_imag(1,1)],'Linewidth',1,'Color',cols(3,:)) 
xlim([-1.05 1.05])
ylim([-1.05 1.05])
title('n=3')
xlabel('real','Fontsize',14)
grid on%ylabel('imag')

axes('Position',[.55+3*delta 2/3 .15 1/4])
ht4 = plot(sig_real(4,1),sig_imag(4,1),'o','Color',cols(4,:),'Linewidth',1);
hl4 = line([0 sig_real(1,1)],[0 sig_imag(1,1)],'Linewidth',1,'Color',cols(4,:)) 
xlim([-1.05 1.05])
ylim([-1.05 1.05])
title('n=4')
xlabel('real','Fontsize',14)
%ylabel('imag')
grid on

axes('Position',[.7+4*delta 2/3 .15 1/4])
ht5 = plot(sig_real(5,1),sig_imag(5,1),'o','Color',cols(5,:),'Linewidth',1);
hl5 = line([0 sig_real(1,1)],[0 sig_imag(1,1)],'Linewidth',1,'Color',cols(5,:)) 
xlim([-1.05 1.05])
ylim([-1.05 1.05])
title('n=5')
xlabel('real','Fontsize',14)
%ylabel('imag')
grid on

axes('Position',[.1 .13 .6+4*delta+.15 .4])
hs = plot(t(1:1),sum_real(1:1),'Color',cols(6,:),'Linewidth',2)
hold on
hc1 = plot(t(1:1),sig_real(1,1),'Color',cols(1,:))
hc2 = plot(t(1:1),sig_real(2,1),'Color',cols(2,:))
hc3 = plot(t(1:1),sig_real(3,1),'Color',cols(3,:))
hc4 = plot(t(1:1),sig_real(4,1),'Color',cols(4,:))
hc5 = plot(t(1:1),sig_real(5,1),'Color',cols(5,:))
xlim([0 T])
ylim([-1.1*nr_components 1.1*nr_components])
xlabel('time / s','Fontsize',14)
ylabel('amplitude / a.u.','Fontsize',14)
grid on

%filename = '../pics/lecture_01-movie-pulsetrain/lecture_01-pulsetrain-frame1.pdf';
%save2pdf_and_crop(filename);
filename = '../pics/lecture_01-movie-pulsetrain/lecture_01-pulsetrain-frame001.png';
saveas(gcf, filename, 'png')



%return

% now the loop that updates the graph
for k=2:length(t)
   set(ht1,'XData',sig_real(1,k),'YData',sig_imag(1,k)); 
   set(hl1,'XData',[0 sig_real(1,k)],'YData',[0 sig_imag(1,k)]) 
   
   set(ht2,'XData',sig_real(2,k),'YData',sig_imag(2,k)); 
   set(hl2,'XData',[0 sig_real(2,k)],'YData',[0 sig_imag(2,k)]) 
   
   set(ht3,'XData',sig_real(3,k),'YData',sig_imag(3,k)); 
   set(hl3,'XData',[0 sig_real(3,k)],'YData',[0 sig_imag(3,k)]) 
   
   set(ht4,'XData',sig_real(4,k),'YData',sig_imag(4,k)); 
   set(hl4,'XData',[0 sig_real(4,k)],'YData',[0 sig_imag(4,k)]) 
   
   set(ht5,'XData',sig_real(5,k),'YData',sig_imag(5,k)); 
   set(hl5,'XData',[0 sig_real(5,k)],'YData',[0 sig_imag(5,k)]) 
   
   set(hs,'XData',t(1:k),'YData',sum_real(1:k));
   set(hc1,'XData',t(1:k),'YData',sig_real(1,1:k));
   set(hc2,'XData',t(1:k),'YData',sig_real(2,1:k));
   set(hc3,'XData',t(1:k),'YData',sig_real(3,1:k));
   set(hc4,'XData',t(1:k),'YData',sig_real(4,1:k));
   set(hc5,'XData',t(1:k),'YData',sig_real(5,1:k));
   
   drawnow;
   
   %filename = ['../pics/lecture_01-movie-pulsetrain/lecture_01-pulsetrain-frame' ...
   %             num2str(k) '.pdf'];
   %save2pdf_and_crop(filename);
   
   filename = ['../pics/lecture_01-movie-pulsetrain/lecture_01-pulsetrain-frame' ...
                num2str(k, '%04.0f') '.png'];
   saveas(gcf, filename, 'png');


end

% convert -delay 20 -loop 0 *.jpg myimage.gif