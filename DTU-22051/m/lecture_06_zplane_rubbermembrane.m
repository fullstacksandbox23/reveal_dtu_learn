% Script to visualize a transfer function in z as a surface plot
close all;
clear all;

% some parameters

r = 1;

%zeros
z1 = r*exp(1i*pi/4);
z2 = r*exp(-1i*pi/4);

%poles
p1 = r*exp(1i*3*pi/4);
p2 = r*exp(-1i*3*pi/4);


[x,y] = meshgrid(-1.5:.01:1.5,-1.5:.01:1.5);
z = x+1i*y;

% Compute the transfer function
magnitude = 20*log10(abs((z-z1).*(z-z2)./((z-p1).*(z-p2))));

% Compute the unit circle
x_uc = cos(2*pi*[0:.001:1]);
y_uc = sin(2*pi*[0:.001:1]);
z_uc = x_uc+1j*y_uc;
magnitude_uc = 20*log10(abs(((z_uc-z1).*(z_uc-z2)./((z_uc-p1).*(z_uc-p2)))));


%% 
prepare_figure_scale(10,10)
hold on;

%% reference plane
f2 = surf(x,y,magnitude*0);
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
plot3(real(z1),imag(z1),0,'o','Markersize',10,'Markerfacecolor',[.7 .7 .7],'Color',[.7 .7 .7],'linewidth',2)
plot3(real(z2),imag(z2),0,'o','Markersize',10,'Markerfacecolor',[.7 .7 .7],'Color',[.7 .7 .7],'linewidth',2)

plot3(real(p1),imag(p1),0,'x','Markersize',10,'Markerfacecolor',[.7 .7 .7],'Color',[.7 .7 .7],'linewidth',2)
plot3(real(p2),imag(p2),0,'x','Markersize',10,'Markerfacecolor',[.7 .7 .7],'Color',[.7 .7 .7],'linewidth',2)

view(45,15)


%% The transfer function
f1 = surf(x,y,magnitude);
set(f1,'Edgealpha',.1,'Facealpha',.8,'Edgecolor','none','Facecolor','interp')
hold on;

xlim([-1.5 1.5])
ylim([-1.5 1.5])
zlim([-30 30])

%% The unit circle

plot3(x_uc,y_uc,magnitude_uc,'Linewidth',2,'Color','r')


%%%%%%%%%%%%%% SAVING %%%%%%%%%%%%%%%%%
path2pics = ['..', filesep, 'pics', filesep];
path2mov = ['lecture_06-movie-zplane-rubbermembrane', filesep];
fname_mov_pre = 'lecture_06-movie-zplane-rubbermembrane_';


fname = ['..', filesep, 'pics', filesep, 'lecture_06_zplane_rubbermembrane.pdf'];
save2pdf_and_crop_res(fname, 300)

%print([fname, '.pdf'], '-dpdf','-r300');
%system(['eps2pdf ', fname, '.eps'])
%system(['pdfcrop ', fname, '.pdf'])
%system[['']]
%save2pdf_and_crop(fname)




%% the animation going through angles
view(0,90)

el = 90:-1:10;
az = 0:45;

K = length(el)+length(az);

frame_nr = 1;

% all elevations
for kk=1:length(el)
    view(0,el(kk))
    save2pdf_and_crop_res([path2pics, path2mov, fname_mov_pre, num2str(frame_nr), '.pdf'], 300);
    frame_nr = frame_nr+1;
end

%all azimuths
for ll=1:length(az)
    view(az(ll),el(end))
    save2pdf_and_crop_res([path2pics, path2mov, fname_mov_pre, num2str(frame_nr), '.pdf'], 300);
    frame_nr = frame_nr+1;
end





