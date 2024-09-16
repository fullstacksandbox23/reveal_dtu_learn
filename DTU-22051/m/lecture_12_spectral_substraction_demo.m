%% some demo script for simple noise reduction via spectral substraction.


close all
clear all

% add path
addpath myspectrogram

% (spectrogram) parameters:
path2wav = ['..' filesep 'sounds' filesep];
wav_file = 'mini-me_short.wav';
%wav_file = 'spoken_sentence.wav';
%wav_file = 'cocktailparty.wav';
nfft = 1024;
len_win = 500;
win = hamming(len_win);
overlap_percent = 50;
overlap_samples = fix(overlap_percent/100*len_win);

snr = 0;

% load wav file
[sig fs] = audioread([path2wav wav_file]);

%% 

% do the spectrogram (STFT)
S_org = myspectrogram(sig,nfft,fs,win,overlap_samples);

% plot the original spectrogram
figure('name','Original file');
imagesc(20*log10(abs(S_org)))
ylim([0 size(S_org,1)/2])
xlabel('Frame number')
ylabel('STFT frequency bin')
caxis([-100 40])
colorbar
%% 

% noising
n = randn(size(sig));

% scale noise
snr_sig = sqrt(mean(sig.^2));
snr_n = sqrt(mean(n.^2));

sig_noised = sig + n/snr_n*snr_sig*10^(-snr/20);
S_noised = myspectrogram(sig_noised,nfft,fs,win,overlap_samples);

%% plot the noise spectrogram
%N = myspectrogram(n/snr_n*snr_sig*10^(snr/20),nfft,fs,win,overlap_samples);
N = myspectrogram(n/snr_n,nfft,fs,win,overlap_samples);

<<<<<<< Updated upstream
prepare_figure_scale(15,10)
=======

figure('Name','Noise')
>>>>>>> Stashed changes
imagesc(20*log10(abs(N)))
ylim([0 size(S_noised,1)/2])
xlabel('Frame number')
ylabel('STFT frequency bin')
caxis([-100 40])
colorbar

% plotting
<<<<<<< Updated upstream
prepare_figure_scale(15,10)
=======
figure('Name','Noisy signal')
>>>>>>> Stashed changes
imagesc(20*log10(abs(S_noised)))
ylim([0 size(S_noised,1)/2])
xlabel('Frame number')
ylabel('STFT frequency bin')
caxis([-100 40])
colorbar

%% now let's see what we can do with the noise
% 1: Estimate the average amplitude over all frequency bands and simply
% substract. This is rather artificial since we do have the noise isolated.
% Normally you would use some smart algorithm to estimate the noise in
% pauses of the speech for example.
E_noise = mean(abs(N(:)));

% now get rid of everything that is below that value
idx_1_sub = find(abs(S_noised)<.1*E_noise);
S_denoised1 = S_noised;
S_denoised1(idx_1_sub) = 0;

<<<<<<< Updated upstream

idx_2_sub = find(abs(S_noised)<.2*E_noise);
=======
idx_2_sub = find(abs(S_noised)<2*E_noise);
>>>>>>> Stashed changes
S_denoised2 = S_noised;
S_denoised2(idx_2_sub) = 0;

idx_3_sub = find(abs(S_noised)<.3*E_noise);
S_denoised3 = S_noised;
S_denoised3(idx_3_sub) = 0;

idx_4_sub = find(abs(S_noised)<.4*E_noise);
S_denoised4 = S_noised;
S_denoised4(idx_4_sub) = 0;

%%


% plotting
<<<<<<< Updated upstream
prepare_figure_scale(15,10)
=======
figure('Name','De-noised  signal (1E)')
>>>>>>> Stashed changes
imagesc(20*log10(abs(S_denoised1)))
ylim([0 size(S_noised,1)/2])
xlabel('Frame number')
ylabel('STFT frequency bin')
caxis([-100 40])
colorbar

% reconstruction of the signal
sig_denoised1 = invmyspectrogram(S_denoised1, overlap_samples);
sig_denoised2 = invmyspectrogram(S_denoised2, overlap_samples);
sig_denoised3 = invmyspectrogram(S_denoised3, overlap_samples);
sig_denoised4 = invmyspectrogram(S_denoised4, overlap_samples);

%% listen to what we got
%soundsc(sig_noised,fs);
%soundsc(sig_denoised1,fs);
%soundsc(sig_denoised2,fs);
%soundsc(sig_denoised3,fs);
%soundsc(sig_denoised4,fs);

%soundsc(sig_denoised2,fs);
% clear sound
%soundsc(sig_denoised2_smart,fs);
%soundsc(sig_denoised4_smart,fs);

%% we can also listen to the estimated noise
N_estimate = zeros(size(N));
N_estimate(idx_1_sub) = N(idx_1_sub);
noise_estimate = invmyspectrogram(N_estimate, overlap_samples);

%sound(noise_estimate, fs)

%return
%% 
%%%%%%
prepare_figure_scale(15,10)
imagesc(20*log10(abs(N)))
ylim([1 nfft/2]);
xlabel('Frame number')
ylabel('STFT frequency bin')
caxis([-100 40])
colorbar

filename = ['..' filesep 'pics' filesep 'lecture_11_noise_spectrogram.pdf'];
save2pdf_and_crop(filename)
filename = ['..' filesep 'pics' filesep 'compressed_lecture_11_noise.png'];
save2png(filename)
audiowrite(['..' filesep 'sounds' filesep 'lecture_11_noise_spectrogram.wav'],n/max(n)*.9,fs)
%%%%%%

%%%%%%
prepare_figure_scale(15,10)
imagesc(20*log10(abs(S_org)))
ylim([1 nfft/2]);
xlabel('Frame number')
ylabel('STFT frequency bin')
caxis([-100 40])
colorbar

filename = ['..' filesep 'pics' filesep 'lecture_11_signal.pdf'];
save2pdf_and_crop(filename)
filename = ['..' filesep 'pics' filesep 'compressed_lecture_11_signal.png'];
save2png(filename)
audiowrite(['..' filesep 'sounds' filesep 'lecture_11_noise_signal.wav'],sig/max(sig)*.9,fs)
%%%%%%

%%%%%%
prepare_figure_scale(15,10)
imagesc(20*log10(abs(S_noised)))
ylim([1 nfft/2]);
xlabel('Frame number')
ylabel('STFT frequency bin')
caxis([-100 40])
colorbar

filename = ['..' filesep 'pics' filesep 'lecture_11_noise_signal.pdf'];
save2pdf_and_crop(filename)
filename = ['..' filesep 'pics' filesep 'compressed_lecture_11_noise_signal.png'];
save2png(filename)
audiowrite(['..' filesep 'sounds' filesep 'lecture_11_noisy_signal.wav'],sig_noised/max(sig_noised)*.9,fs)
%%%%%%


%%%%%%
prepare_figure_scale(15,10)
imagesc(20*log10(abs(S_denoised1)))
ylim([1 nfft/2]);
xlabel('Frame number')
ylabel('STFT frequency bin')
caxis([-100 40])
colorbar

filename = ['..' filesep 'pics' filesep 'lecture_11_denoised_1.pdf'];
save2pdf_and_crop(filename)
filename = ['..' filesep 'pics' filesep 'compressed_lecture_11_denoised_1.png'];
save2png(filename)
audiowrite(['..' filesep 'sounds' filesep 'lecture_11_sig_denoised_1.wav'],sig_denoised1/max(sig_denoised1)*.9,fs)
%%%%%%


%%%%%%
prepare_figure_scale(15,10)
imagesc(20*log10(abs(S_denoised2)))
ylim([1 nfft/2]);
xlabel('Frame number')
ylabel('STFT frequency bin')
caxis([-100 40])
colorbar

filename = ['..' filesep 'pics' filesep 'lecture_11_denoised_2.pdf'];
save2pdf_and_crop(filename)
filename = ['..' filesep 'pics' filesep 'compressed_lecture_11_denoised_2.png'];
save2png(filename)
audiowrite(['..' filesep 'sounds' filesep 'lecture_11_sig_denoised_2.wav'],sig_denoised2/max(sig_denoised2)*.9,fs)
%%%%%%


%%%%%%
prepare_figure_scale(15,10)
imagesc(20*log10(abs(S_denoised3)))
ylim([1 nfft/2]);
xlabel('Frame number')
ylabel('STFT frequency bin')
caxis([-100 40])
colorbar

filename = ['..' filesep 'pics' filesep 'lecture_11_denoised_3.pdf'];
save2pdf_and_crop(filename)
filename = ['..' filesep 'pics' filesep 'compressed_lecture_11_denoised_3.png'];
save2png(filename)
audiowrite(['..' filesep 'sounds' filesep 'lecture_11_sig_denoised_3.wav'],sig_denoised3/max(sig_denoised3)*.9,fs)
%%%%%%



%%%%%%
prepare_figure_scale(15,10)
imagesc(20*log10(abs(S_denoised4)))
ylim([1 nfft/2]);
xlabel('Frame number')
ylabel('STFT frequency bin')
caxis([-100 40])
colorbar

filename = ['..' filesep 'pics' filesep 'lecture_11_denoised_4.pdf'];
save2pdf_and_crop(filename)
filename = ['..' filesep 'pics' filesep 'compressed_lecture_11_denoised_4.png'];
save2png(filename)
audiowrite(['..' filesep 'sounds' filesep 'lecture_11_sig_denoised_4.wav'],sig_denoised4/max(sig_denoised4)*.9,fs)
%%%%%%


