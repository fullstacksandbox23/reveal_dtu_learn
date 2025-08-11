%% lecture 2 - DEMO
%
% Recording an impuse response and convolve it with some sound signal.
%
% Latext change: 2015/09/09 BEPP

%% clean up
clear all
close all

%% info about the SC
%info_sc = audiodevinfo;


%% set some parameters etc.
fs = 44100;     % sampling frequency to be used
nbits = 16;     % bits per sample
rec_id = 3;     % recording channel ID
play_id = 2;    % playback channel ID
path2audio = ['..' filesep 'sounds' filesep];
audio_fname = 'lecture01_demo_mini-me_short.wav'; 

%% Prepare the audio recorder/player object
recObj = audiorecorder(44100,nbits,1,rec_id);

%% record impulse response
record(recObj);

%% stop recording and write data into vector
stop(recObj);
h = getaudiodata(recObj);

%% play sound
playObj = audioplayer(h,fs);
play(playObj);

%% record signal
record(recObj);

%% stop recording and write data into vector
stop(recObj);
sig = getaudiodata(recObj);

%% play sound
playObj = audioplayer(sig,fs);
play(playObj);

%% do the convolution and play the sound
sig_h = conv(h,sig);
sound(sig_h,fs)

%% load a wav file
[sig_wav fs_wav] = audioread([path2audio audio_fname]);

%% do the convolution and do play the sound
sig_wav_h = conv(h,sig_wav);
% do some normalization to avoid too high amplitudes
sig_wav_h = sig_wav_h/max(sig_wav_h)*.8;
sound(sig_wav_h,fs)