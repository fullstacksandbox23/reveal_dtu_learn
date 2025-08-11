import numpy as np
import matplotlib.pyplot as plt
from scipy.io import wavfile

# Parameters
fs = 22050  # Sampling frequency
f = 1000    # Frequency of the pure tone
T = 1
t = np.linspace(0, T, int(fs * T), endpoint=False)  # Time vector from 0 to 100ms

# Generate pure tone signal
signal = np.sin(2 * np.pi * f * t)

# Compute magnitude spectrum
magnitude_spectrum = np.abs(np.fft.rfft(signal))
frequencies = np.fft.rfftfreq(len(signal), 1/fs)

# Plotting
fig, (ax1, ax2) = plt.subplots(2, 1, figsize=(8, 4))

# Upper panel: Magnitude spectrum
ax1.stem(frequencies, magnitude_spectrum)
ax1.set_title('Magnitude Spectrum of a Pure Tone at 1000 Hz')
ax1.set_xlabel('Frequency (Hz)')
ax1.set_ylabel('Magnitude (a.u.)')
ax1.set_xlim([0, 2000])
ax1.set_ylim([0, 450])
ax1.grid()

# Lower panel: Time signal
ax2.plot(t * 1000, signal)  # Convert time to milliseconds for better readability
ax2.set_title('Time Signal of a Pure Tone at 1000 Hz')
ax2.set_xlabel('Time (ms)')
ax2.set_ylabel('Amplitude')
ax2.set_xlim([0, 100])
ax2.grid()

plt.tight_layout()
plt.savefig("../pics/lecture_10_time_freq_tone.svg")
plt.show()

## New plot with spectrogram
fig, (axs1, axs2) = plt.subplots(2, 1, figsize=(8, 4))
axs1.specgram(signal, NFFT = 1024, Fs=fs, noverlap=512, cmap='viridis')
axs1.set_title('Spectrogram of a pure tone')
axs1.set_xlabel('Time (s)')
axs1.set_ylabel('Frequency (Hz)')
axs1.set_ylim([0, 4000])

axs2.plot(t, signal)  # Convert time to milliseconds for better readability
axs2.set_title('Time Signal of a pure tone')
axs2.set_xlabel('Time (s)')
axs2.set_ylabel('Amplitude')
axs2.set_xlim([0, .1])
axs2.grid()

plt.tight_layout()
plt.savefig("../pics/lecture_10_time_freq_tone_specgram.svg")
plt.show()


# store signal in WAV
wavfile.write("../wav/lecture_10_tone.wav", fs, np.array(signal*32767,dtype=np.int16))