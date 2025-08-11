import numpy as np
import matplotlib.pyplot as plt
from scipy.signal import get_window, freqz

plt.rcParams.update({'font.size': 16})

# Define window types
window_types = ['boxcar', 'bartlett', 'hann', 'hamming', 'blackman', ('kaiser', 14)]

# Define the length of the window
N = 51

# Create a figure with two subplots
fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(12, 6))

# Plot time domain windows on the left panel
for window_type in window_types:
    if isinstance(window_type, tuple):
        window = get_window(window_type, N)
        label = f"{window_type[0].capitalize()} "
    else:
        window = get_window(window_type, N)
        label = window_type.capitalize()
    ax1.plot(window, label=label)

ax1.set_title('Window Functions in Time Domain')
ax1.set_xlabel('Sample')
ax1.set_ylabel('Amplitude')
ax1.legend()

# Plot magnitude response on the right panel
for window_type in window_types:
    if isinstance(window_type, tuple):
        window = get_window(window_type, N)
        label = f"{window_type[0].capitalize()} "
    else:
        window = get_window(window_type, N)
        label = window_type.capitalize()
    w, h = freqz(window, worN=8000)
    ax2.plot(w, 20*np.log10(np.abs(h)), label=label)

ax2.set_title('Magnitude Response of Window Functions')
ax2.set_xlabel('Normalized Frequency')
ax2.set_ylabel('Magnitude (dB)')
ax2.set_xlim([0, 1])
ax2.set_ylim([-51, 61])
ax2.legend()

plt.tight_layout()

plt.savefig('../pics/lecture_08_windows.svg', transparent=True)

plt.show()
