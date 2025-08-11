import numpy as np
import matplotlib.pyplot as plt
from scipy.signal import freqz

plt.rcParams.update({'font.size': 16})

# Define the order of the running sum filter
order = 5

# Create the impulse response of the running sum filter
impulse_response_even = np.concatenate((np.ones(order), np.zeros(order*2)))
impulse_response_odd = np.concatenate((np.ones(2), [0], -1*np.ones(2),  np.zeros(order*2)))
impulse_response_asym = np.concatenate((np.ones(3), -1*np.ones(2), np.zeros(order*2)))

# Compute the frequency response of the running sum filter
w, h_even = freqz(impulse_response_even)
w, h_odd = freqz(impulse_response_odd)
w, h_asym = freqz(impulse_response_asym)

# Plot the impulse response even
plt.figure(figsize=(10, 5))

ax = plt.subplot(1, 2, 1)
plt.stem(impulse_response_even)
plt.title('Impulse Response')
plt.xlabel('Sample')
plt.ylabel('Amplitude')
ax.set_ylim([-1.1, 1.1])

# Plot the frequency response
ax_tf = plt.subplot(1, 2, 2)
plt.plot(w/np.pi, 20 * np.log10(abs(h_even)))
plt.title('Frequency Response')
plt.xlabel('Frequency (normalised)')
plt.ylabel('Magnitude (dB)')
ax_tf.set_ylim([-45, 15])

# Create a mirrored axis for phase response
ax_phase = plt.gca().twinx()
angles = (np.angle(h_even))
ax_phase.plot(w/np.pi, angles, 'g', label='Phase (radians)', alpha=.2, lw=4)
ax_phase.set_ylabel('Phase (radians)', color='g')
ax_phase.set_ylim([-5, 5])

plt.tight_layout()
plt.savefig('../pics/lecture_08_rs_time_freq_even.svg', transparent=True)

# Show the plots

plt.show()



# Plot the impulse response odd
plt.figure(figsize=(10, 5))

ax = plt.subplot(1, 2, 1)
plt.stem(impulse_response_odd)
plt.title('Impulse Response')
plt.xlabel('Sample')
plt.ylabel('Amplitude')
ax.set_ylim([-1.1, 1.1])

# Plot the frequency response
ax_tf = plt.subplot(1, 2, 2)
plt.plot(w/np.pi, 20 * np.log10(abs(h_odd)))
plt.title('Frequency Response')
plt.xlabel('Frequency (normalised)')
plt.ylabel('Magnitude (dB)')
ax_tf.set_ylim([-45, 15])

# Create a mirrored axis for phase response
ax_phase = plt.gca().twinx()
angles = (np.angle(h_odd))
ax_phase.plot(w/np.pi, angles, 'g', label='Phase (radians)', alpha=.2, lw=4)
ax_phase.set_ylabel('Phase (radians)', color='g')
ax_phase.set_ylim([-5, 5])

plt.tight_layout()
plt.savefig('../pics/lecture_08_rs_time_freq_odd.svg', transparent=True)

# Show the plots
plt.show()


# Plot the impulse response asymm
plt.figure(figsize=(10, 5))

ax = plt.subplot(1, 2, 1)
plt.stem(impulse_response_asym)
plt.title('Impulse Response')
plt.xlabel('Sample')
plt.ylabel('Amplitude')
ax.set_ylim([-1.1, 1.1])

# Plot the frequency response
ax_tf = plt.subplot(1, 2, 2)
plt.plot(w/np.pi, 20 * np.log10(abs(h_asym)))
plt.title('Frequency Response')
plt.xlabel('Frequency (normalised)')
plt.ylabel('Magnitude (dB)')
ax_tf.set_ylim([-45, 15])

# Create a mirrored axis for phase response
ax_phase = plt.gca().twinx()
angles = (np.angle(h_asym))
ax_phase.plot(w/np.pi, angles, 'g', label='Phase (radians)', alpha=.2, lw=4)
ax_phase.set_ylabel('Phase (radians)', color='g')
ax_phase.set_ylim([-5, 5])


plt.tight_layout()
plt.savefig('../pics/lecture_08_rs_time_freq_asym.svg', transparent=True)

# Show the plots
plt.show()


