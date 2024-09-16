function lecture11_noisedemo(path2sound,filename)
% Function to demonstrate  the existance and processing of noise in
% arbitrary recordings
%
%   Function call:
%       >> lecture11_noisedemo(path2sound,filename)

% clean up
close all

% plotting stuff
cols = [0 0 .6; .6 0 0; 0 .6 0];
lw = 2;
font_size=16;
nr_bins = 100;
%% 
% get the sound file
disp(['Using sound file ' path2sound filesep filename]);

[s fs] = wavread([path2sound filesep filename]);
t = 0:1/fs:(length(s)-1)/fs;

% play back the sound file
% disp('Playing back the sound file - press a key');
% pause
% sound(s,fs);

% scaling factor
k = 1;
s_scale = s;
% while max(s_scale) < 1
%     s_scale = s_scale*2^k;
%     disp(['PLAYING BACK THE SOUND FILE - ' ...
%         num2str(2^k) ' times the original amplitude......'])
%     sound(s_scale,fs)    
%     % increase scaling
%     k = k+1;
% end    

%% compute the mean and average
mu = mean(s(:,1));
sigma = std(s(:,1));

disp(['Estimated mean and std of sequence: \mu=' num2str(mu) ...
    ', \sigma = ' num2str(sigma)]);

% scale the bins
X_min = min(s);
X_max = max(s);

X = linspace(X_min,X_max,nr_bins);

% count the amplitudes
[N Xs] = hist(s,X);
% normalize
N_s_norm = N/sum(N); 

% and estimate a gaussian distribution
s_fit = normpdf(X,mu,sigma);
% normalize
s_fit = s_fit/sum(s_fit);


%% plotting
screen_size = get(0,'ScreenSize');
figure('Position',[0 0 screen_size(3)/3 screen_size(4)/4])
h1 = plot(t,s,'Color',cols(1,:)); hold on;
set(h1,'Linewidth',2);
hl1 = xlabel('Time / s')
hl2 = ylabel('Amplitde / a.u.')

set([hl1 hl2],'Fontsize',font_size);
set(gca,'Fontsize',font_size)

legend('Data')

figure('Position',[0 screen_size(4)/2 screen_size(3)/3 screen_size(4)/2])
h2 = plot(X,N_s_norm,'Color',cols(1,:),'Linewidth',lw); hold on
h3 = plot(X,s_fit,'Color',cols(2,:),'Linewidth',lw);

hl1 = xlabel('Amplitude / a.u.')
hl2 = ylabel('Probability / %')

set([hl1 hl2],'Fontsize',font_size);
set(gca,'Fontsize',font_size)

legend('Data','Estimated')


%% producing some noise of the same length as the recording with same ..
% mean and std
disp('And now the artifical thing...')
pause

r = mu + sigma*randn(length(s),1);

% disp('Playing back the sound file - press a key');
% pause
% sound(r,fs);

% scaling factor
k = 1;
r_scale = r;
% while max(r_scale) < 1
%     r_scale = r_scale*2^k;
%     disp(['PLAYING BACK THE NOISE - ' ...
%         num2str(2^k) ' times the original amplitude......'])
%     sound(r_scale,fs)    
%     % increase scaling
%     k = k+1;
% end    

%% compute the mean and average
mu = mean(r);
sigma = std(r);

disp(['Estimated mean and std of sequence: \mu=' num2str(mu) ...
    ', \sigma = ' num2str(sigma)]);

% count the amplitudes
[N Xr] = hist(r,X);
% normalize
N_norm = N/sum(N); 

% and estimate a gaussian distribution
r_fit = normpdf(X,mu,sigma);
% normalize
r_fit = r_fit/sum(r_fit);


%% plotting
screen_size = get(0,'ScreenSize');
figure('Position',[0 0 screen_size(3)/3 screen_size(4)/4])
h1 = plot(t,s,'Color',cols(1,:)); hold on;
h2 = plot(t,r,'Color',cols(3,:)); 
set(h1,'Linewidth',2);
hl1 = xlabel('Time / s')
hl2 = ylabel('Amplitde / a.u.')

set([hl1 hl2],'Fontsize',font_size);
set(gca,'Fontsize',font_size)

legend('Data','Simulation')


figure('Position',[0 screen_size(4)/2 screen_size(3)/3 screen_size(4)/2])
h3 = plot(X,N_norm,'Color',cols(1,:),'Linewidth',lw); hold on
h4 = plot(X,N_s_norm,'Color',cols(2,:),'Linewidth',lw);
h5 = plot(X,r_fit,'Color',cols(3,:),'Linewidth',lw);

hl1 = xlabel('Amplitude / a.u.');
hl2 = ylabel('Probability / %');

set([hl1 hl2],'Fontsize',font_size);
set(gca,'Fontsize',font_size)

legend('Simulated','Data','Estimated')

