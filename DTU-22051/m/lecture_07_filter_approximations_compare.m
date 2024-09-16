close all;
clear all;

% Visualization of different filter approximations in terms of order and
% steepness of the transition band

% Some parameters
n = 2;              % order of filter

% passband specs
w_p = .1;           % normalized frequency
G_p = -8;           % Min -8 dB gain in passband (or at most 8 dB attenuation)

% stopband specs
w_s = .4;           % stopband frequency
G_s = -80;          % at most -80 dB (or at least 80 dB attenutation)

% acceptable ripples
R_p = 5;            % rippple height in passband
R_s = 80;           % minimum ripple attenuation


%%%%% BASED ON SPECS%%%%%%%%


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

                    
figure()                    
freqz(B_butt, A_butt); hold on;
freqz(B_cheb1, A_cheb1)
freqz(B_cheb2, A_cheb2)
freqz(B_ellip, A_ellip)

line([0 w_p],[G_p G_p],'Linewidth',3,'Color','k')
line([w_p w_p],[G_p -100],'Linewidth',3,'Color','k')

line([w_s 1],[G_s G_s],'Linewidth',3,'Color','k')
line([w_s w_s],[G_s G_s+100],'Linewidth',3,'Color','k')

line([0 w_p],[-R_p -R_p],'Linewidth',1,'Color','k','Linestyle','--')

ylim([G_s-20 10])
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
