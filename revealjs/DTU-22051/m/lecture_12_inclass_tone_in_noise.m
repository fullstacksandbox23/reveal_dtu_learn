%% demonstration of the Welch method of power spectral density estimation
close all
% signal parameters
fs = 10000;
T = 10;
t = 0:1/fs:T-1/fs;
f = 4000;
sigma = 1;
n = sigma*randn(T*fs,1);

% generate the signal
sig = sin(2*pi*f*t);
sig_noised = n+sig';

% estimate the power spectral density by a periodogram
figure
periodogram(sig_noised)

% estimate the power spectral density by a Welch method
figure
pwelch(sig_noised)