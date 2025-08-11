import numpy as np
import matplotlib.pyplot as plt
from scipy.signal import chirp, spectrogram
from scipy.io import wavfile


# Parameters
fs = 22050  # Sampling frequency
T = 1
t = np.linspace(0, T, int(fs * T), endpoint=False)  # Time vector from 0 to 100ms

f_start = 100    # Start frequency of the sweep
f_end = 1500   # End frequency of the sweep

# signal = np.sin(2 * np.pi * ((f_start + (f_end - f_start) * t / t[-1]) * t))
signal = chirp(t, f0=f_start, f1=f_end, t1=T, method='linear')

# Compute magnitude spectrum
magnitude_spectrum = np.abs(np.fft.rfft(signal))
frequencies = np.fft.rfftfreq(len(signal), 1/fs)

# Plotting
fig, (ax1, ax2) = plt.subplots(2, 1, figsize=(8, 4))

# Upper panel: Magnitude spectrum
ax1.stem(frequencies, magnitude_spectrum)
ax1.set_title('Magnitude Spectrum of an upward sweep')
ax1.set_xlabel('Frequency (Hz)')
ax1.set_ylabel('Magnitude (a.u.)')
ax1.set_xlim([0, 2000])
ax1.set_ylim([0, 140])
ax1.grid()

# Lower panel: Time signal
ax2.plot(t, signal)  # Convert time to milliseconds for better readability
ax2.set_title('Time Signal of a Pure Tone at 1000 Hz')
ax2.set_xlabel('Time (ms)')
ax2.set_ylabel('Amplitude')
ax2.set_xlim([0, 1])
ax2.grid()

plt.tight_layout()
plt.savefig("../pics/lecture_10_time_freq_sweep_up.svg")
plt.show()

## New plot with spectrogram
fig, (axs1, axs2) = plt.subplots(2, 1, figsize=(8, 4))
axs1.specgram(signal, NFFT = 1024, Fs=fs, noverlap=512, cmap='viridis')
axs1.set_title('Spectrogram of an upward sweep')
axs1.set_xlabel('Time (s)')
axs1.set_ylabel('Frequency (Hz)')
axs1.set_ylim([0, 4000])

axs2.plot(t, signal)  # Convert time to milliseconds for better readability
axs2.set_title('Time Signal of an upward sweep')
axs2.set_xlabel('Time (s)')
axs2.set_ylabel('Amplitude')
axs2.set_xlim([0, 1])
axs2.grid()

plt.tight_layout()
plt.savefig("../pics/lecture_10_time_freq_sweep_up_specgram.svg")
plt.show()

# store signal in WAV
wavfile.write("../wav/lecture_10_upward_sweep.wav", fs, np.array(signal*32767,dtype=np.int16))