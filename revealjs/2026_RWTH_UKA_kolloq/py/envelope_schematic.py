import numpy as np
import matplotlib.pyplot as plt
from scipy.io import wavfile
from scipy.signal import hilbert, butter, filtfilt

def generate_bam(duration=0.5, fs=40000):
    """
    Generate a 'BAM'-like signal using:
    sinusoid * low-pass filtered noise
    """
    t = np.linspace(0, duration, int(fs * duration), endpoint=False)
    
    # Base sinusoid (low frequency "thump")
    freq = 200  # Hz
    sinusoid = np.sin(2 * np.pi * freq * t) 
    
    # Generate white noise
    noise = np.random.rand(len(t))-.5
    
    # Low-pass filter design
    cutoff = 30  # Hz
    order = 4
    nyq = 0.5 * fs
    b, a = butter(order, cutoff / nyq, btype='low')
    
    # Apply filter to noise
    filtered_noise = filtfilt(b, a, noise)
    
    # Normalize filtered noise
    filtered_noise /= np.max(np.abs(filtered_noise))
    
    # Combine: sinusoid * filtered noise
    bam = sinusoid * 5*filtered_noise
    
    
    return fs, bam

def load_wav(file_path):
    fs, data = wavfile.read(file_path)
    
    if data.dtype != np.float32 and data.dtype != np.float64:
        data = data / np.max(np.abs(data))
    
    if len(data.shape) > 1:
        data = data[:, 0]
    
    return fs, data

def compute_envelope(signal):
    analytic_signal = hilbert(signal)
    return np.abs(analytic_signal)

def plot_signal(fs, signal, save_svg=False, svg_filename="signal.svg"):
    t = np.arange(len(signal)) / fs
    env = compute_envelope(signal)
    env_max = np.max(env)
    
    fig = plt.figure(figsize=(12.8*.6, 7.2*.6))  # 16:9
    
    plt.plot(t, signal, color='blue', label='signal')
    plt.plot(t, env, color='green', linewidth=4, label='envelope')
    

    plt.xlim([.1, .4])
    plt.ylim([-1.1, 1.1])

    plt.xticks([])
    plt.yticks([])


    plt.xlabel("time / a.u.", fontsize = 20)
    plt.ylabel("amplitude / a.u.", fontsize = 20)
    plt.legend()





    # Add horizontal zero line
    plt.axhline(0, color='black', linewidth=1)
    
    # Remove axes completely
    ax = plt.gca()
    ax.set_xticks([])
    ax.set_yticks([])
    for spine in ax.spines.values():
        spine.set_visible(False)




    
    plt.tight_layout()
    
    if save_svg:
        plt.savefig(
            svg_filename,
            format="svg",
            transparent=True,
            bbox_inches="tight"
        )
        print(f"SVG saved as: {svg_filename}")
    
    

# -------------------------------
# MAIN USAGE
# -------------------------------

# OPTION 1: Synthetic "BAM"
fs, signal = generate_bam()

# OPTION 2: Load WAV file
# fs, signal = load_wav("your_file.wav")

plot_signal(fs, signal, save_svg=True, svg_filename="envelope_example.svg")