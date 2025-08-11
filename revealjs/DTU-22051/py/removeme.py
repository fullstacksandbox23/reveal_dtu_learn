import numpy as np
import matplotlib.pyplot as plt

# Parameters
fs = 44100  # Sampling frequency
t = np.linspace(0, 0.1, int(fs * 0.1), endpoint=False)  # Time vector from 0 to 100ms


# Generate downward sweep signal
f_start = 2000   # Start frequency of the sweep
f_end = 500    # End frequency of the sweep
sweep_signal = np.sin(2 * np.pi * ((f_start - (f_start - f_end) * t / t[-1]) * t))

# Apply Hann window
hann_window = np.hanning(len(sweep_signal))
windowed_signal = sweep_signal * hann_window

# Compute magnitude spectrum
magnitude_spectrum = np.abs(np.fft.rfft(windowed_signal))
frequencies = np.fft.rfftfreq(len(windowed_signal), 1/fs)

# Plotting
fig, (ax1, ax2) = plt.subplots(2, 1, figsize=(10, 6))

# Upper panel: Magnitude spectrum with stem plot
ax1.stem(frequencies, magnitude_spectrum, use_line_collection=True)
ax1.set_title('Magnitude Spectrum of a Downward Sweep with Hann Window')
ax1.set_xlabel('Frequency (Hz)')
ax1.set_ylabel('Magnitude')
ax1.grid()

# Lower panel: Time signal
ax2.plot(t * 1000, windowed_signal)  # Convert time to milliseconds for better readability
ax2.set_title('Time Signal of a Downward Sweep with Hann Window')
ax2.set_xlabel('Time (ms)')
ax2.set_ylabel('Amplitude')
ax2.grid()

plt.tight_layout()
plt.show()
