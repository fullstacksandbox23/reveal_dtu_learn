import numpy as np
import matplotlib.pyplot as plt
from scipy.io import wavfile
from scipy.signal import convolve, resample

# filenames
path2wav = "../wav/"

#hname = "lecture_02_factoryhall"
#hname = "lecture_02_vaccuumcleaner"
#hname = "lecture_02_smallspeaker"
#hname = "lecture_02_bucket"
#hname = "lecture_02_bath"

fname = "lecture_01_mini-me_short"

# Load the impulse response
rate_h, h = wavfile.read(path2wav + hname + ".wav")
h = h/np.max(h)

# Load the input signal
rate_sig, sig = wavfile.read(path2wav + fname + ".wav")
sig = sig/np.max(sig)


# Ensure both signals are mono or handle stereo appropriately
if h.ndim > 1:
    h = h[:, 0]  # Use first channel
if sig.ndim > 1:
    sig = sig[:, 0]  # Use first channel

if rate_h != rate_sig:
    print("Resanmpling")
    print(rate_h)
    print(rate_sig)
    h = resample(h, rate_sig)

plt.plot(sig)
plt.plot(h)
plt.show()


# Perform convolution
conv_result = convolve(sig, h, mode='full')

plt.plot(conv_result)


# Normalize to prevent clipping
conv_result = conv_result / np.max(np.abs(conv_result)) * 32767
conv_result = conv_result.astype(np.int16)

# Save the result
resname = path2wav + "conv_" + hname + "_" + fname + "wav"
wavfile.write(resname, rate_sig, conv_result)
