import numpy as np
from scipy.io.wavfile import write

# ============================================================
# Parameters
# ============================================================
fs = 44100                  # Sampling frequency (Hz)
duration = 10.0             # Duration of all signals (s)
ramp_duration = 0.020       # Raised-cosine onset/offset ramp (20 ms)

# ============================================================
# Utility function: raised-cosine ramps
# ============================================================
def apply_raised_cosine_ramp(signal, fs, ramp_duration):
    """
    Apply a raised-cosine onset and offset ramp.
    """
    n_ramp = int(ramp_duration * fs)

    ramp_on = 0.5 * (1 - np.cos(np.pi * np.arange(n_ramp) / n_ramp))
    ramp_off = ramp_on[::-1]

    envelope = np.ones(len(signal))
    envelope[:n_ramp] *= ramp_on
    envelope[-n_ramp:] *= ramp_off

    return signal * envelope

# ============================================================
# Time vector
# ============================================================
t = np.arange(int(duration * fs)) / fs

# ============================================================
# Signal 1:
# 500 Hz tone with amplitude rising linearly from 0 to 1
# ============================================================
amplitude_ramp = t / duration
silence_duration = 1.0
signal1 = amplitude_ramp * np.sin(2 * np.pi * 500 * t)

signal1 = apply_raised_cosine_ramp(signal1, fs, ramp_duration)



# Add leading and trailing silence
silence = np.zeros(int(silence_duration * fs))
signal1 = np.concatenate((silence, signal1, silence))


# Normalize for WAV export
signal1_wav = np.int16(signal1 / np.max(np.abs(signal1)) * 32767)

write("../snd/signal1_500Hz_rising_amplitude.wav", fs, signal1_wav)

# ============================================================
# Signal 2:
# Sum of two tones: 1000 Hz and 1220 Hz
# ============================================================
signal2 = (
    0.2 * np.sin(2 * np.pi * 1000 * t)
    + 0.8 * np.sin(2 * np.pi * 1220 * t)
)

signal2 = apply_raised_cosine_ramp(signal2, fs, ramp_duration)

signal2_wav = np.int16(signal2 / np.max(np.abs(signal2)) * 32767)

write("../snd/signal2_1000Hz_1220Hz.wav", fs, signal2_wav)

# ============================================================
# Signal 3:
# Series of 10 ms pulses
# Example: 100 ms ON, 100 ms OFF repeatedly
# ============================================================
pulse_duration = 0.001       # 100 ms
pulse_samples = int(pulse_duration * fs)

envelope = np.zeros_like(t)

idx = 0
while idx < len(envelope):
    end_idx = min(idx + pulse_samples, len(envelope))
    envelope[idx:end_idx] = 1.0
    idx += 100 * pulse_samples  # ON + OFF

# Apply 20 ms raised-cosine ramps to each pulse
n_ramp = int(ramp_duration * fs)
ramp = 0.5 * (1 - np.cos(np.pi * np.arange(n_ramp) / n_ramp))

start_indices = np.where(np.diff(np.concatenate(([0], envelope))) > 0)[0]

for start in start_indices:
    stop = min(start + pulse_samples, len(envelope))

    #if stop - start > 2 * n_ramp:
    #    envelope[start:start+n_ramp] *= ramp
    #    envelope[stop-n_ramp:stop] *= ramp[::-1]

# Use a 500 Hz carrier tone inside the pulses
carrier_freq = 500
signal3 = envelope #* np.sin(2 * np.pi * carrier_freq * t)

signal3_wav = np.int16(signal3 / np.max(np.abs(signal3)) * 32767)

write("../snd/signal3_100ms_pulses.wav", fs, signal3_wav)

print("WAV files created:")
print("  signal1_500Hz_rising_amplitude.wav")
print("  signal2_1000Hz_1220Hz.wav")
print("  signal3_100ms_pulses.wav")