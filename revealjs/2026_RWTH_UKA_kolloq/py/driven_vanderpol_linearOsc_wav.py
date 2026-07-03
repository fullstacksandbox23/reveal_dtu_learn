import numpy as np
import matplotlib.pyplot as plt
from matplotlib.animation import FuncAnimation
from scipy.integrate import solve_ivp
from scipy.signal import spectrogram

# ============================================================
# PARAMETERS
# ============================================================

duration = 40.0          # seconds
fs = 1000                # sampling rate (Hz)

# Oscillator parameters
f0 = 10                 # natural frequency (Hz)
fd = 15                 # drive frequency (Hz)

omega0 = 2 * np.pi * f0
omegad = 2 * np.pi * fd

mu = 8.0                 # strong nonlinearity
A = 20.0                 # strong driving amplitude

# ============================================================
# DRIVE ENVELOPE
# ============================================================
#
# 0-20 s      : no drive
# 20-30 s     : linear ramp from 0 to A
# 30-40 s     : no drive
#
# ============================================================

def envelope(t):

    t = np.asarray(t)
    env = np.zeros_like(t)

    ramp = (t >= 10.0) & (t < 20.0)

    env[ramp] = A * (t[ramp] - 20.0) / 10.0

    return env


def drive(t):

    amp = envelope(np.array([t]))[0]

    return amp * np.sin(omegad * t)

# ============================================================
# DRIVEN VAN DER POL OSCILLATOR
#
# x'' - μ(1-x²)x' + ω₀²x = F(t)
#
# ============================================================

def vdp_driven(t, y):

    x, v = y

    dxdt = v

    dvdt = (
        mu * (1 - x**2) * v
        - omega0**2 * x
        + drive(t)
    )

    return [dxdt, dvdt]

# ============================================================
# SIMULATE
# ============================================================

t = np.arange(0, duration, 1/fs)

y0 = [0.1, 0.0]

sol = solve_ivp(
    vdp_driven,
    (0, duration),
    y0,
    t_eval=t,
    rtol=1e-8,
    atol=1e-10,
    method="RK45"
)

if not sol.success:
    raise RuntimeError(sol.message)

x = sol.y[0]

# ============================================================
# DRIVE FOR PLOTTING
# ============================================================

F = envelope(t) * np.sin(omegad * t)

F_scaled = (
    F / np.max(np.abs(F))
    * np.max(np.abs(x))
)

# ============================================================
# SPECTROGRAM
# ============================================================

f_spec, t_spec, Sxx = spectrogram(
    x,
    fs=fs,
    window="hann",
    nperseg=4096,
    noverlap=3800,
    scaling="density",
    mode="psd"
)

Sxx_db = 10 * np.log10(Sxx + 1e-12)

# ============================================================
# FIGURE
# ============================================================

fig = plt.figure(figsize=(14, 9))

ax_wave = plt.subplot(2, 1, 1)
ax_spec = plt.subplot(2, 1, 2)

# ============================================================
# TOP PANEL : SCROLLING WAVEFORM
# ============================================================

window = 10.0

ymax = 1.1 * max(
    np.max(np.abs(x)),
    np.max(np.abs(F_scaled))
)

ax_wave.set_ylim(-ymax, ymax)
ax_wave.set_xlim(0, window)

ax_wave.set_title(
    "Driven Van der Pol Oscillator\n"
    f"f₀={f0} Hz, fdrive={fd} Hz, μ={mu}, A={A}"
)

ax_wave.set_ylabel("Amplitude")
ax_wave.grid(True)

force_line, = ax_wave.plot(
    [],
    [],
    color="lightgray",
    lw=2,
    label="Driving Force"
)

osc_line, = ax_wave.plot(
    [],
    [],
    color="red",
    lw=1.5,
    label="Oscillator"
)

cursor_wave = ax_wave.axvline(
    0,
    color="black",
    ls="--",
    lw=1
)

time_text = ax_wave.text(
    0.02,
    0.92,
    "",
    transform=ax_wave.transAxes,
    fontsize=12
)

ax_wave.legend()

# ============================================================
# BOTTOM PANEL : SPECTROGRAM
# ============================================================

initial_spec = np.full_like(Sxx_db, np.nan)

mesh = ax_spec.pcolormesh(
    t_spec,
    f_spec,
    initial_spec,
    shading="auto",
    cmap="viridis",
    vmin=np.percentile(Sxx_db, 5),
    vmax=np.percentile(Sxx_db, 99)
)

ax_spec.set_xlim(0, duration)
ax_spec.set_ylim(0, 20)

ax_spec.set_xlabel("Time (s)")
ax_spec.set_ylabel("Frequency (Hz)")
ax_spec.set_title("Spectrogram")

cursor_spec = ax_spec.axvline(
    0,
    color="white",
    lw=2
)

cbar = plt.colorbar(mesh, ax=ax_spec)
cbar.set_label("Power (dB)")

# ============================================================
# ANIMATION INITIALIZATION
# ============================================================

def init():

    force_line.set_data([], [])
    osc_line.set_data([], [])

    cursor_wave.set_xdata([0, 0])
    cursor_spec.set_xdata([0, 0])

    time_text.set_text("")

    return (
        force_line,
        osc_line,
        cursor_wave,
        cursor_spec,
        time_text,
        mesh
    )

# ============================================================
# ANIMATION UPDATE
# ============================================================

samples_per_frame = 50

def update(frame):

    idx = min(
        frame * samples_per_frame,
        len(t) - 1
    )

    t_now = t[idx]

    # --------------------------------------------------------
    # SCROLLING WINDOW
    # --------------------------------------------------------

    left = max(0.0, t_now - window)

    right = left + window

    if right > duration:
        right = duration
        left = duration - window

    ax_wave.set_xlim(left, right)

    force_line.set_data(
        t[:idx],
        F_scaled[:idx]
    )

    osc_line.set_data(
        t[:idx],
        x[:idx]
    )

    cursor_wave.set_xdata([t_now, t_now])

    time_text.set_text(
        f"Time = {t_now:.2f} s"
    )

    # --------------------------------------------------------
    # REVEAL SPECTROGRAM
    # --------------------------------------------------------

    visible = t_spec <= t_now

    spec_visible = np.full_like(
        Sxx_db,
        np.nan
    )

    spec_visible[:, visible] = Sxx_db[:, visible]

    mesh.set_array(spec_visible.ravel())

    cursor_spec.set_xdata(
        [t_now, t_now]
    )

    return (
        force_line,
        osc_line,
        cursor_wave,
        cursor_spec,
        time_text,
        mesh
    )

# ============================================================
# ANIMATE
# ============================================================

ani = FuncAnimation(
    fig,
    update,
    frames=len(t) // samples_per_frame,
    init_func=init,
    interval=20,
    blit=False
)

plt.tight_layout()
plt.show()

# ============================================================
# SAVE MOVIE (OPTIONAL)
# ============================================================
#
# Requires ffmpeg installed.
#
# ani.save(
#     "van_der_pol_entrainment.mp4",
#     writer="ffmpeg",
#     fps=30,
#     dpi=150
# )
#
# ============================================================