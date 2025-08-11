import numpy as np
import matplotlib.pyplot as plt
from scipy.io import wavfile


fs, signal = wavfile.read("../wav/lecture_01_railroad.wav")

# Parameters
t = np.arange(0, len(signal)/fs, 1/fs)  # Time vector from 0 to 100ms


# Compute magnitude spectrum
magnitude_spectrum = 20*np.log10(np.abs(np.fft.rfft(signal)))
frequencies = np.fft.rfftfreq(len(signal), 1/fs)

# Plotting
fig, (ax1, ax2) = plt.subplots(2, 1, figsize=(8, 4))

# Upper panel: Magnitude spectrum
ax1.stem(frequencies, magnitude_spectrum)
ax1.set_title('Magnitude Spectrum of a Pure Tone at 1000 Hz')
ax1.set_xlabel('Frequency (Hz)')
ax1.set_ylabel('Magnitude (a.u.)')
#ax1.set_xlim([0, 2000])
ax1.set_ylim([68, 152])
ax1.grid()

# Lower panel: Time signal
ax2.plot(t * 1000, signal)  # Convert time to milliseconds for better readability
ax2.set_title('Time Signal from wav-file')
ax2.set_xlabel('Time (ms)')
ax2.set_ylabel('Amplitude (a.u.)')
#ax2.set_xlim([0, 100])
ax2.grid()

plt.tight_layout()
plt.savefig("../pics/lecture_10_time_freq_wav.svg")
plt.show()

## New plot with spectrogram
fig, (axs1, axs2) = plt.subplots(2, 1, figsize=(8, 4))
axs1.specgram(signal, NFFT = 100, Fs=fs, noverlap=90, cmap='viridis')
axs1.set_title('Spectrogram of speech signal')
axs1.set_xlabel('Time (s)')
axs1.set_ylabel('Frequency (Hz)')
axs1.set_ylim([0, 4000])

axs2.plot(t, signal)  # Convert time to milliseconds for better readability
axs2.set_title('Time signal of speech signal')
axs2.set_xlabel('Time (s)')
axs2.set_ylabel('Amplitude')
#axs2.set_xlim([0, .1])
axs2.grid()

plt.tight_layout()
plt.savefig("../pics/lecture_10_time_freq_wav_specgram.svg")
plt.show()

