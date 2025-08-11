import numpy as np
import scipy.io.wavfile as wav
from scipy.signal import stft, istft
import matplotlib.pyplot as plt

# parameters
nfft = 512

# Read the .wav file
sample_rate, data = wav.read('../wav/lecture_01_mini-me_short.wav')

# noise
noise_sigma_sq = .1*np.max(data)

noise = noise_sigma_sq*np.random.randn(np.size(data))

noisy_data = data + noise

# Calculate the STFT using a Hann window
f0, t0, Zxx0 = stft(data, fs=sample_rate, window='hann', nperseg=nfft)

print(np.max(np.abs(Zxx0)))

f, t, Zxx = stft(noisy_data, fs=sample_rate, window='hann', nperseg=nfft)

# Perform spectral subtraction (for simplicity, we will subtract a constant noise spectrum)
noise_spectrum = np.mean(np.mean(np.abs(Zxx)))

print(noise_spectrum)
print(np.max(abs(Zxx)))

Zxx_denoised_1 = np.maximum(Zxx - 1*noise_spectrum,1e-2)
Zxx_denoised_2 = np.maximum(Zxx - 2*noise_spectrum,1e-2)
Zxx_denoised_3 = np.maximum(Zxx - 5*noise_spectrum,1e-2)

# Reconstruct the time signal using the overlap-add algorithm
_, data_reconstructed_0 = istft(Zxx, fs=sample_rate, window='hann', nperseg=nfft)
_, data_reconstructed_1 = istft(Zxx_denoised_1, fs=sample_rate, window='hann', nperseg=nfft)
_, data_reconstructed_2 = istft(Zxx_denoised_2, fs=sample_rate, window='hann', nperseg=nfft)
_, data_reconstructed_3 = istft(Zxx_denoised_3, fs=sample_rate, window='hann', nperseg=nfft)

# plotting
plt.figure(figsize=(6,4))
vertmax = 10.*np.log10(np.max(np.max(np.abs(Zxx0))))
vertmin = 10.*np.log10(1e-2)

plt.specgram(data, NFFT = nfft, Fs=sample_rate, noverlap=90, cmap='viridis', vmin = vertmin, vmax = vertmax)
plt.title('Spectrogram of speech signal')
plt.xlabel('Time (s)')
plt.ylabel('Frequency (Hz)')
plt.tight_layout()
plt.savefig("../pics/lecture_12_spectral_subtraction_org.svg")

plt.specgram(data_reconstructed_0, NFFT = nfft, Fs=sample_rate, noverlap=90, cmap='viridis', vmin = vertmin, vmax = vertmax)
plt.savefig("../pics/lecture_12_spectral_subtraction_0.svg")
plt.specgram(data_reconstructed_1, NFFT = nfft, Fs=sample_rate, noverlap=90, cmap='viridis', vmin = vertmin, vmax = vertmax)
plt.savefig("../pics/lecture_12_spectral_subtraction_1.svg")
plt.specgram(data_reconstructed_2, NFFT = nfft, Fs=sample_rate, noverlap=90, cmap='viridis', vmin = vertmin, vmax = vertmax)
plt.savefig("../pics/lecture_12_spectral_subtraction_2.svg")
plt.specgram(data_reconstructed_3, NFFT = nfft, Fs=sample_rate, noverlap=90, cmap='viridis', vmin = vertmin, vmax = vertmax)
plt.savefig("../pics/lecture_12_spectral_subtraction_3.svg")



# Store the processed file in a .wav format
wav.write('../wav/lecture_12_spectral_subtraction_0.wav', sample_rate, data_reconstructed_0.astype(np.int16))
wav.write('../wav/lecture_12_spectral_subtraction_1.wav', sample_rate, data_reconstructed_1.astype(np.int16))
wav.write('../wav/lecture_12_spectral_subtraction_2.wav', sample_rate, data_reconstructed_2.astype(np.int16))
wav.write('../wav/lecture_12_spectral_subtraction_3.wav', sample_rate, data_reconstructed_3.astype(np.int16))
