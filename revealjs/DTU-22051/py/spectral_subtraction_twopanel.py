import numpy as np
import scipy.io.wavfile as wav
from scipy.signal import stft, istft
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D

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
fig = plt.figure(figsize=(12, 4))
vertmax = 20.*np.log10(np.max(np.max(np.abs(Zxx0))))
vertmin = 20.*np.log10(1e-2)


# Plot spectrogram as image
ax1 = fig.add_subplot(121)
ax1.specgram(data, NFFT=nfft, Fs=sample_rate, noverlap=90, cmap='viridis', vmin = vertmin, vmax = vertmax)
ax1.set_title('Spectrogram of speech signal')
ax1.set_xlabel('Time (s)')
ax1.set_ylabel('Frequency (Hz)')

# Plot spectrogram as surface in 3D
ax2 = fig.add_subplot(122, projection='3d')
T, F = np.meshgrid(t0, f0)
Z = 20 * np.log10(np.abs(Zxx0))
ax2.plot_surface(T, F, Z, cmap='viridis')
ax2.set_title('Spectrogram of speech signal (3D)')
ax2.set_xlabel('Time (s)')
ax2.set_ylabel('Frequency (Hz)')
ax2.set_zlabel('Magnitude (dB)')
ax2.set_zlim([-65, 75])

# Change the view of the 3D plot
ax2.view_init(elev=30., azim=60)

plt.tight_layout()
plt.savefig("../pics/lecture_12_spectral_subtraction_org_combined.svg")

fig = plt.figure(figsize=(12, 4))

# Plot spectrogram as image
ax1 = fig.add_subplot(121)
ax1.specgram(data_reconstructed_0, NFFT=nfft, Fs=sample_rate, noverlap=90, cmap='viridis', vmin = vertmin, vmax = vertmax)
ax1.set_title('Spectrogram of noisy speech signal')
ax1.set_xlabel('Time (s)')
ax1.set_ylabel('Frequency (Hz)')

# Plot spectrogram as surface in 3D
ax2 = fig.add_subplot(122, projection='3d')
T, F = np.meshgrid(t0, f0)
Z = 20 * np.log10(np.abs(Zxx))
ax2.plot_surface(T, F, Z, cmap='viridis')
ax2.set_title('Spectrogram of noisy speech signal (3D)')
ax2.set_xlabel('Time (s)')
ax2.set_ylabel('Frequency (Hz)')
ax2.set_zlabel('Magnitude (dB)')
ax2.set_zlim([-65, 75])

# Change the view of the 3D plot
ax2.view_init(elev=30., azim=240)

plt.tight_layout()
plt.savefig("../pics/lecture_12_spectral_subtraction_0_combined.svg")

fig = plt.figure(figsize=(12, 4))

# Plot spectrogram as image
ax1 = fig.add_subplot(121)
ax1.specgram(data_reconstructed_1, NFFT=nfft, Fs=sample_rate, noverlap=90, cmap='viridis', vmin = vertmin, vmax = vertmax)
ax1.set_title('Spectrogram of denoised speech signal (1x noise spectrum)')
ax1.set_xlabel('Time (s)')
ax1.set_ylabel('Frequency (Hz)')

# Plot spectrogram as surface in 3D
ax2 = fig.add_subplot(122, projection='3d')
T, F = np.meshgrid(t0, f0)
Z = 20 * np.log10(np.abs(Zxx_denoised_1))
ax2.plot_surface(T, F, Z, cmap='viridis')
ax2.set_title('Spectrogram of denoised speech signal (1x noise spectrum) (3D)')
ax2.set_xlabel('Time (s)')
ax2.set_ylabel('Frequency (Hz)')
ax2.set_zlabel('Magnitude (dB)')
ax2.set_zlim([-65, 75])

# Change the view of the 3D plot
ax2.view_init(elev=30., azim=240)

plt.tight_layout()
plt.savefig("../pics/lecture_12_spectral_subtraction_1_combined.svg")

fig = plt.figure(figsize=(12, 4))

# Plot spectrogram as image
ax1 = fig.add_subplot(121)
ax1.specgram(data_reconstructed_2, NFFT=nfft, Fs=sample_rate, noverlap=90, cmap='viridis', vmin = vertmin, vmax = vertmax)
ax1.set_title('Spectrogram of denoised speech signal (2x noise spectrum)')
ax1.set_xlabel('Time (s)')
ax1.set_ylabel('Frequency (Hz)')

# Plot spectrogram as surface in 3D
ax2 = fig.add_subplot(122, projection='3d')
T, F = np.meshgrid(t0, f0)
Z = 20 * np.log10(np.abs(Zxx_denoised_2))
ax2.plot_surface(T, F, Z, cmap='viridis')
ax2.set_title('Spectrogram of denoised speech signal (2x noise spectrum) (3D)')
ax2.set_xlabel('Time (s)')
ax2.set_ylabel('Frequency (Hz)')
ax2.set_zlabel('Magnitude (dB)')
ax2.set_zlim([-65, 75])

# Change the view of the 3D plot
ax2.view_init(elev=30., azim=240)

plt.tight_layout()
plt.savefig("../pics/lecture_12_spectral_subtraction_2_combined.svg")

fig = plt.figure(figsize=(12, 4))

# Plot spectrogram as image
ax1 = fig.add_subplot(121)
ax1.specgram(data_reconstructed_3, NFFT=nfft, Fs=sample_rate, noverlap=90, cmap='viridis', vmin = vertmin, vmax = vertmax)
ax1.set_title('Spectrogram of denoised speech signal (5x noise spectrum)')
ax1.set_xlabel('Time (s)')
ax1.set_ylabel('Frequency (Hz)')

# Plot spectrogram as surface in 3D
ax2 = fig.add_subplot(122, projection='3d')
T, F = np.meshgrid(t0, f0)
Z = 20 * np.log10(np.abs(Zxx_denoised_3))
ax2.plot_surface(T, F, Z, cmap='viridis')
ax2.set_title('Spectrogram of denoised speech signal (5x noise spectrum) (3D)')
ax2.set_xlabel('Time (s)')
ax2.set_ylabel('Frequency (Hz)')
ax2.set_zlabel('Magnitude (dB)')
ax2.set_zlim([-65, 75])

# Change the view of the 3D plot
ax2.view_init(elev=30., azim=240)

plt.tight_layout()
plt.savefig("../pics/lecture_12_spectral_subtraction_3_combined.svg")

# Store the processed file in a .wav format
wav.write('../wav/lecture_12_spectral_subtraction_0.wav', sample_rate, data_reconstructed_0.astype(np.int16))
wav.write('../wav/lecture_12_spectral_subtraction_1.wav', sample_rate, data_reconstructed_1.astype(np.int16))
wav.write('../wav/lecture_12_spectral_subtraction_2.wav', sample_rate, data_reconstructed_2.astype(np.int16))
wav.write('../wav/lecture_12_spectral_subtraction_3.wav', sample_rate, data_reconstructed_3.astype(np.int16))