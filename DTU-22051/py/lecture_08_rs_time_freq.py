import numpy as np
import matplotlib.pyplot as plt
from scipy.signal import freqz

# Define the order of the running sum filter
order = 5

# Create the impulse response of the running sum filter
impulse_response = np.concatenate((np.ones(order), np.zeros(order*2)))

# Compute the frequency response of the running sum filter
w, h = freqz(impulse_response)

# Plot the impulse response
plt.figure(figsize=(12, 6))

plt.subplot(1, 2, 1)
plt.stem(impulse_response)
plt.title('Impulse Response')
plt.xlabel('Sample')
plt.ylabel('Amplitude')

# Plot the frequency response
plt.subplot(1, 2, 2)
plt.plot(w/np.pi, 20 * np.log10(abs(h)))
plt.title('Frequency Response')
plt.xlabel('Frequency (normalised)')
plt.ylabel('Magnitude (dB)')

# Create a mirrored axis for phase response
ax_phase = plt.gca().twinx()
angles = np.unwrap(np.angle(h))
ax_phase.plot(w/np.pi, angles, 'g', label='Phase (radians)')
ax_phase.set_ylabel('Phase (radians)', color='g')


# Show the plots
plt.tight_layout()
plt.show()
