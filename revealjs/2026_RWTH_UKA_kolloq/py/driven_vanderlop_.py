import numpy as np
import matplotlib.pyplot as plt
from scipy.integrate import solve_ivp
from scipy.signal import spectrogram

# --------------------------------------------------
# Parameters
# --------------------------------------------------

f0 = 1.0          # Natural frequency of Van der Pol oscillator (Hz)
fd = 1.5          # Driving frequency (Hz)
A = 1.0           # Final driving amplitude
mu = 1.0          # Van der Pol nonlinearity parameter

duration = 11.0   # Total simulation time (s)
fs = 1000         # Sampling frequency for output (Hz)

omega0 = 2 * np.pi * f0
omegad = 2 * np.pi * fd

# --------------------------------------------------
# Driving force envelope
# --------------------------------------------------
# 0-1 s     : amplitude = 0
# 1-10 s    : linear ramp to A
# 10-11 s   : amplitude = 0

def envelope(t):
    t = np.asarray(t)

    env = np.zeros_like(t, dtype=float)

    ramp = (t >= 1) & (t < 10)
    env[ramp] = A * (t[ramp] - 1) / 9.0

    return env


def driving_force(t):
    amp = envelope(np.array([t]))[0]
    return amp * np.sin(omegad * t)

# --------------------------------------------------
# Driven Van der Pol oscillator
# x'' - mu(1-x²)x' + omega0² x = F(t)
# --------------------------------------------------

def vdp_driven(t, y):
    x, v = y

    dxdt = v
    dvdt = (
        mu * (1 - x**2) * v
        - omega0**2 * x
        + driving_force(t)
    )

    return [dxdt, dvdt]


# --------------------------------------------------
# Simulation
# --------------------------------------------------

t = np.arange(0, duration, 1/fs)

y0 = [0.01, 0.0]

sol = solve_ivp(
    vdp_driven,
    (0, duration),
    y0,
    t_eval=t,
    rtol=1e-8,
    atol=1e-10
)

x = sol.y[0]

force = envelope(t) * np.sin(omegad * t)

# Scale force for visualization
force_plot = force / np.max(np.abs(force)) * np.max(np.abs(x))

# --------------------------------------------------
# Spectrogram
# --------------------------------------------------

f_spec, t_spec, Sxx = spectrogram(
    x,
    fs=fs,
    window='hann',
    nperseg=2048,
    noverlap=1800,
    scaling='density',
    mode='psd'
)

Sxx_db = 10 * np.log10(Sxx + 1e-12)

# --------------------------------------------------
# Plotting
# --------------------------------------------------

fig, ax = plt.subplots(
    2,
    1,
    figsize=(12, 8),
    constrained_layout=True
)

# --------------------------------
# Plot 1: Time series
# --------------------------------
ax[0].plot(
    t,
    force_plot,
    color='lightgray',
    linewidth=2,
    label='Driving force (scaled)'
)

ax[0].plot(
    t,
    x,
    color='red',
    linewidth=1.5,
    label='Van der Pol oscillator'
)

ax[0].set_title('Driven Van der Pol Oscillator')
ax[0].set_xlabel('Time (s)')
ax[0].set_ylabel('Amplitude')
ax[0].legend()
ax[0].grid(True)

# --------------------------------
# Plot 2: Spectrogram
# --------------------------------
im = ax[1].pcolormesh(
    t_spec,
    f_spec,
    Sxx_db,
    shading='gouraud',
    cmap='viridis'
)

ax[1].set_ylim(0, 5)
ax[1].set_xlabel('Time (s)')
ax[1].set_ylabel('Frequency (Hz)')
ax[1].set_title('Spectrogram of Oscillator Amplitude')

cbar = fig.colorbar(im, ax=ax[1])
cbar.set_label('Power (dB)')

plt.show()