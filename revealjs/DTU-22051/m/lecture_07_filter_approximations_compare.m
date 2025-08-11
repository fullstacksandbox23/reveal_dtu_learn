close all;
clear all;

% Visualization of different filter approximations in terms of order and
% steepness of the transition band

prepare_figure_scale(15,10)

% Some parameters
n = 2;              % order of filter

% passband specs
w_p = .3;           % normalized frequency
G_p = -10;           % Min -8 dB gain in passband (or at most 8 dB attenuation)

% stopband specs
w_s = .35;           % stopband frequency
G_s = -40;          % at most -80 dB (or at least 80 dB attenutation)

% acceptable ripples
R_p = 9;            % rippple height in passband
R_s = 30;           % minimum ripple attenuation

% signals
fs = 8000;
T = 10;
t = 0:1/fs:T-1/fs;

sweep  = chirp(t, 50, T, 0.9*fs/2, 'linear')/sqrt(2);
noise = randn(1,fs*T);
noise = noise/sqrt(mean(noise.^2));



%%%%% BASED ON SPECS%%%%%%%%

%% LP

% Make a Butterworth filter
[n_butt, Wn] = buttord(w_p, w_s, -G_p, -G_s);
                    % NOTE: normalized frequencies and positive numbers as
                    % gains/attenautions (referred to as "passband ripple"
                    % and "stopband attenuation") G_p and G_s

[B_butt, A_butt] = butter(n_butt, Wn);
                    % This will provide us with the filter coefficients
                                       
% Make a Chebychev I filter
[n_cheb1, Wn] = cheb1ord(w_p, w_s, R_p, -G_s);
                    % NOTE: normalized frequencies and positive numbers as
                    % gains/attenautions (referred to as "passband ripple"
                    % and "stopband attenuation") G_p and G_s

[B_cheb1, A_cheb1] = cheby1(n_cheb1, R_p, Wn);
                    % This will provide us with the filter coefficients
                    % where the ripples are not higher than 

                   
% Make a Chebychev II filter
[n_cheb2, Wn] = cheb2ord(w_p, w_s, -R_p, -G_s);
                    % NOTE: normalized frequencies and positive numbers as
                    % gains/attenautions (referred to as "passband ripple"
                    % and "stopband attenuation") G_p and G_s

[B_cheb2, A_cheb2] = cheby2(n_cheb2, R_s, Wn);
                    % This will provide us with the filter coefficients

% Make an Elliptic (Cauer) filter
[n_ellip, Wn] = ellipord(w_p, w_s, -G_p, -G_s);
                    % NOTE: normalized frequencies and positive numbers as
                    % gains/attenautions (referred to as "passband ripple"
                    % and "stopband attenuation") G_p and G_s

[B_ellip, A_ellip] = ellip(n_ellip, R_p, R_s, Wn);
                    % This will provide us with the filter coefficients

                  
H_butt_LP = freqz(B_butt, A_butt); %hold on;
H_cheb1_LP = freqz(B_cheb1, A_cheb1);
H_cheb2_LP = freqz(B_cheb2, A_cheb2);
H_ellip_LP = freqz(B_ellip, A_ellip);


sweep_BW_LP = filter(B_butt, A_butt, sweep);
noise_BW_LP = filter(B_butt, A_butt, noise);
sweep_cheb1_LP = filter(B_cheb1, A_cheb1, sweep);
noise_cheb1_LP = filter(B_cheb1, A_cheb1, noise);
sweep_cheb2_LP = filter(B_cheb2, A_cheb2, sweep);
noise_cheb2_LP = filter(B_cheb2, A_cheb2, noise);
sweep_ellip_LP = filter(B_ellip, A_ellip, sweep);
noise_ellip_LP = filter(B_ellip, A_ellip, noise);


audiowrite('../wav/lecture_07_demo_sweep_BW_LP.wav', norm2wav(sweep_BW_LP), fs);
audiowrite('../wav/lecture_07_demo_sweep_cheb1_LP.wav', norm2wav(sweep_cheb1_LP), fs)
audiowrite('../wav/lecture_07_demo_sweep_cheb2_LP.wav', norm2wav(sweep_cheb2_LP), fs)
audiowrite('../wav/lecture_07_demo_sweep_ellip_LP.wav', norm2wav(sweep_ellip_LP), fs)
audiowrite('../wav/lecture_07_demo_noise_BW_LP.wav', norm2wav(noise_BW_LP), fs);
audiowrite('../wav/lecture_07_demo_noise_cheb1_LP.wav', norm2wav(noise_cheb1_LP), fs)
audiowrite('../wav/lecture_07_demo_noise_cheb2_LP.wav', norm2wav(noise_cheb2_LP), fs)
audiowrite('../wav/lecture_07_demo_noise_ellip_LP.wav', norm2wav(noise_ellip_LP), fs)

prepare_figure_scale(5,5)
fnorm = (0:length(H_butt_LP)-1)/(length(H_butt_LP));
plot(fnorm, 20*log10(abs(H_butt_LP)), 'LineWidth',3); hold on
plot(fnorm, 20*log10(abs(H_cheb1_LP)), 'LineWidth',3)
plot(fnorm, 20*log10(abs(H_cheb2_LP)), 'LineWidth',3)
plot(fnorm, 20*log10(abs(H_ellip_LP)), 'LineWidth',3)
xlabel('Frequency (normalized)')
ylabel('Gain (dB)')
ylim([-82, 5])


saveas(gcf,['..', filesep, 'pics', filesep, 'lecture_07_demo_filter_approximations_compare_LP.svg'],'svg')
close(gcf)

%% HP 
% Some parameters
n = 2;              % order of filter

% passband specs
w_p = .3;           % normalized frequency
G_p = -8;           % Min -8 dB gain in passband (or at most 8 dB attenuation)

% stopband specs
w_s = .35;           % stopband frequency
G_s = -24;          % at most -80 dB (or at least 80 dB attenutation)

% acceptable ripples
R_p = 10;            % rippple height in passband
R_s = 20;           % minimum ripple attenuation



% Make a Butterworth filter
[n_butt, Wn] = buttord(w_p, w_s, G_p, G_s);
                    % NOTE: normalized frequencies and positive numbers as
                    % gains/attenautions (referred to as "passband ripple"
                    % and "stopband attenuation") G_p and G_s

[B_butt_HP, A_butt_HP] = butter(n_butt, Wn, 'high');
                    % This will provide us with the filter coefficients
                                       
% Make a Chebychev I filter
[n_cheb1, Wn] = cheb1ord(w_p, w_s, R_p, -G_s);
                    % NOTE: normalized frequencies and positive numbers as
                    % gains/attenautions (referred to as "passband ripple"
                    % and "stopband attenuation") G_p and G_s

[B_cheb1_HP, A_cheb1_HP] = cheby1(n_cheb1, R_p, Wn, 'high');
                    % This will provide us with the filter coefficients
                    % where the ripples are not higher than 


                    
% Make a Chebychev II filter
[n_cheb2, Wn] = cheb2ord(w_s, w_p, -R_p, -G_s);
                    % NOTE: normalized frequencies and positive numbers as
                    % gains/attenautions (referred to as "passband ripple"
                    % and "stopband attenuation") G_p and G_s

[B_cheb2_HP, A_cheb2_HP] = cheby2(n_cheb2, R_s, Wn, 'high');
                    % This will provide us with the filter coefficients

% Make an Elliptic (Cauer) filter
[n_ellip, Wn] = ellipord(w_p, w_s, -G_p, -G_s);
                    % NOTE: normalized frequencies and positive numbers as
                    % gains/attenautions (referred to as "passband ripple"
                    % and "stopband attenuation") G_p and G_s

[B_ellip_HP, A_ellip_HP] = ellip(n_ellip, R_p, R_s, Wn, 'high');
                    % This will provide us with the filter coefficients

                    
H_butt_HP = freqz(B_butt_HP, A_butt_HP); %hold on;
H_cheb1_HP = freqz(B_cheb1_HP, A_cheb1_HP);
H_cheb2_HP = freqz(B_cheb2_HP, A_cheb2_HP);
H_ellip_HP = freqz(B_ellip_HP, A_ellip_HP);


sweep_BW_HP = filter(B_butt_HP, A_butt_HP, sweep);
noise_BW_HP = filter(B_butt_HP, A_butt_HP, noise);
sweep_cheb1_HP = filter(B_cheb1_HP, A_cheb1_HP, sweep);
noise_cheb1_HP = filter(B_cheb1_HP, A_cheb1_HP, noise);
sweep_cheb2_HP = filter(B_cheb2_HP, A_cheb2_HP, sweep);
noise_cheb2_HP = filter(B_cheb2_HP, A_cheb2_HP, noise);
sweep_ellip_HP = filter(B_ellip_HP, A_ellip_HP, sweep);
noise_ellip_HP = filter(B_ellip_HP, A_ellip_HP, noise);


prepare_figure_scale(5,5)
fnorm = (0:length(H_butt_HP)-1)/(length(H_butt_HP));
plot(fnorm, 20*log10(abs(H_butt_HP)), 'LineWidth',3); hold on
plot(fnorm, 20*log10(abs(H_cheb1_HP)), 'LineWidth',3)
plot(fnorm, 20*log10(abs(H_cheb2_HP)), 'LineWidth',3)
plot(fnorm, 20*log10(abs(H_ellip_HP)), 'LineWidth',3)
xlabel('Frequency (normalized)')
ylabel('Gain (dB)')
ylim([-82, 5])


saveas(gcf,['..', filesep, 'pics', filesep, 'lecture_07_demo_filter_approximations_compare_HP.svg'],'svg')
close(gcf)




audiowrite('../wav/lecture_07_demo_sweep_BW_HP.wav', norm2wav(sweep_BW_HP), fs);
audiowrite('../wav/lecture_07_demo_sweep_cheb1_HP.wav',norm2wav( sweep_cheb1_HP), fs)
audiowrite('../wav/lecture_07_demo_sweep_cheb2_HP.wav', norm2wav(sweep_cheb2_HP), fs)
audiowrite('../wav/lecture_07_demo_sweep_ellip_HP.wav', norm2wav(sweep_ellip_HP), fs)
audiowrite('../wav/lecture_07_demo_noise_BW_HP.wav', norm2wav(noise_BW_HP), fs);
audiowrite('../wav/lecture_07_demo_noise_cheb1_HP.wav', norm2wav(noise_cheb1_HP), fs)
audiowrite('../wav/lecture_07_demo_noise_cheb2_HP.wav', norm2wav(noise_cheb2_HP), fs)
audiowrite('../wav/lecture_07_demo_noise_ellip_HP.wav', norm2wav(noise_ellip_HP), fs)


%% BP
% Some parameters
n = 2;              % order of filter

% passband specs
w_pl = .3;           % normalized frequency
w_pu = .6;           % normalized frequency

G_p = -8;           % Min -8 dB gain in passband (or at most 8 dB attenuation)

% stopband specs
w_sl = .2;           % stopband frequency
w_su = .7;           % stopband frequency

G_s = -20;          % at most -80 dB (or at least 80 dB attenutation)

% acceptable ripples
R_p = 5;            % rippple height in passband
R_s = 20;           % minimum ripple attenuation


% Make a Butterworth filter
[n_butt, Wn] = buttord([w_pl w_pu], [w_sl w_su], G_p, G_s);
                    % NOTE: normalized frequencies and positive numbers as
                    % gains/attenautions (referred to as "passband ripple"
                    % and "stopband attenuation") G_p and G_s[w_sl w_su]

[B_butt_BP, A_butt_BP] = butter(n_butt, Wn, 'bandpass');
                    % This will provide us with the filter coefficients
                                       
% Make a Chebychev I filter
[n_cheb1, Wn] = cheb1ord([w_pl w_pu], [w_sl w_su], R_p, -G_s);
                    % NOTE: normalized frequencies and positive numbers as
                    % gains/attenautions (referred to as "passband ripple"
                    % and "stopband attenuation") G_p and G_s

[B_cheb1_BP, A_cheb1_BP] = cheby1(n_cheb1, R_p, Wn, 'bandpass');
                    % This will provide us with the filter coefficients
                    % where the ripples are not higher than 


                    
% Make a Chebychev II filter
[n_cheb2, Wn] = cheb2ord([w_sl w_su], [w_pl w_pu], -R_p, -G_s);
                    % NOTE: normalized frequencies and positive numbers as
                    % gains/attenautions (referred to as "passband ripple"
                    % and "stopband attenuation") G_p and G_s

[B_cheb2_BP, A_cheb2_BP] = cheby2(n_cheb2, R_s, Wn, 'bandpass');
                    % This will provide us with the filter coefficients

% Make an Elliptic (Cauer) filter
[n_ellip, Wn] = ellipord([w_pl w_pu], [w_sl w_su], -G_p, -G_s);
                    % NOTE: normalized frequencies and positive numbers as
                    % gains/attenautions (referred to as "passband ripple"
                    % and "stopband attenuation") G_p and G_s

[B_ellip_BP, A_ellip_BP] = ellip(n_ellip, R_p, R_s, Wn, 'bandpass');
                    % This will provide us with the filter coefficients

                    
H_butt_BP = freqz(B_butt_BP, A_butt_BP); %hold on;
H_cheb1_BP = freqz(B_cheb1_BP, A_cheb1_BP);
H_cheb2_BP = freqz(B_cheb2_BP, A_cheb2_BP);
H_ellip_BP = freqz(B_ellip_BP, A_ellip_BP);

sweep_BW_BP = filter(B_butt_BP, A_butt_BP, sweep);
noise_BW_BP = filter(B_butt_BP, A_butt_BP, noise);
sweep_cheb1_BP = filter(B_cheb1_BP, A_cheb1_BP, sweep);
noise_cheb1_BP = filter(B_cheb1_BP, A_cheb1_BP, noise);
sweep_cheb2_BP = filter(B_cheb2_BP, A_cheb2_BP, sweep);
noise_cheb2_BP = filter(B_cheb2_BP, A_cheb2_BP, noise);
sweep_ellip_BP = filter(B_ellip_BP, A_ellip_BP, sweep);
noise_ellip_BP = filter(B_ellip_BP, A_ellip_BP, noise);



prepare_figure_scale(5,5)
fnorm = (0:length(H_butt_HP)-1)/(length(H_butt_HP));
plot(fnorm, 20*log10(abs(H_butt_BP)), 'LineWidth',3); hold on
plot(fnorm, 20*log10(abs(H_cheb1_BP)), 'LineWidth',3)
plot(fnorm, 20*log10(abs(H_cheb2_BP)), 'LineWidth',3)
plot(fnorm, 20*log10(abs(H_ellip_BP)), 'LineWidth',3)
xlabel('Frequency (normalized)')
ylabel('Gain (dB)')
ylim([-82, 5])


saveas(gcf,['..', filesep, 'pics', filesep, 'lecture_07_demo_filter_approximations_compare_BP.svg'],'svg')
close(gcf)





audiowrite('../wav/lecture_07_demo_sweep_BW_BP.wav', norm2wav(sweep_BW_BP), fs);
audiowrite('../wav/lecture_07_demo_sweep_cheb1_BP.wav',norm2wav( sweep_cheb1_BP), fs)
audiowrite('../wav/lecture_07_demo_sweep_cheb2_BP.wav',norm2wav( sweep_cheb2_BP), fs)
audiowrite('../wav/lecture_07_demo_sweep_ellip_BP.wav', norm2wav(sweep_ellip_BP), fs)
audiowrite('../wav/lecture_07_demo_noise_BW_BP.wav', norm2wav(noise_BW_BP), fs);
audiowrite('../wav/lecture_07_demo_noise_cheb1_BP.wav', norm2wav(noise_cheb1_BP), fs)
audiowrite('../wav/lecture_07_demo_noise_cheb2_BP.wav', norm2wav(noise_cheb2_BP), fs)
audiowrite('../wav/lecture_07_demo_noise_ellip_BP.wav', norm2wav(noise_ellip_BP), fs)

%% Plotting





% line([0 w_p],[G_p G_p],'Linewidth',3,'Color','k')
% line([w_p w_p],[G_p -100],'Linewidth',3,'Color','k')
% 
% line([w_s 1],[G_s G_s],'Linewidth',3,'Color','k')
% line([w_s w_s],[G_s G_s+100],'Linewidth',3,'Color','k')
% 
% line([0 w_p],[-R_p -R_p],'Linewidth',1,'Color','k','Linestyle','--')
% 
% ylim([G_s-20 10])
% 
% %%%%%%%%%%% BASED ON ORDER (FIXED) %%%%%%%%%%%%%%
% figure()
% 
% [b_butt, a_butt] = butter(n, w_p);
% [b_cheb1, a_cheb1] = cheby1(n,R_p,w_p);
% [b_cheb2, a_cheb2] = cheby2(n,R_s,w_s);
% [b_ellip, a_ellip] = ellip(n,R_p,R_s,w_p);
% 
% freqz(b_butt, a_butt); hold on;
% freqz(b_cheb1, a_cheb1)
% freqz(b_cheb2, a_cheb2)
% freqz(b_ellip, a_ellip)
% ylim([G_s-20 10])
% 
% line([0 w_p],[-3 -3],'Linewidth',3,'Color','k')
% line([w_p w_p],[-3 -100],'Linewidth',3,'Color','k')
% 
% 



function out = norm2wav(in)

out = in/(max(in))*.9;

end