import numpy as np
import matplotlib.pyplot as plt
from matplotlib.animation import FuncAnimation, PillowWriter
from scipy.integrate import solve_ivp
from scipy.signal import spectrogram

# ============================================================
# PARAMETERS
# ============================================================

duration = 19.0           # seconds
fs = 1000                # sampling rate (Hz)

# Van der Pol oscillator
f0 = 5.0                 # natural frequency (Hz)
fd = 6.0                 # driving frequency (Hz)

omega0 = 2 * np.pi * f0
omegad = 2 * np.pi * fd

mu = 3.0                 # nonlinearity
A = 800.0                 # maximum driving amplitude


# ============================================================
# LINEAR OSCILLATOR
# ============================================================

fL = 5.5           # resonance frequency (Hz)
zeta = 0.02        # weak damping

omegaL = 2*np.pi*fL

f1 = 5.0           # constant drive
f2 = 6.0           # ramped drive

omega1 = 2*np.pi*f1
omega2 = 2*np.pi*f2

F1_amp = 1.0
F2_amp = 1.0


# ============================================================
# DRIVING FORCE ENVELOPE
#
# 0–1 s : no drive
# 1–7 s : linear ramp from 0 to A
# 7–8 s : no drive
# ============================================================

def envelope(t):

    t = np.asarray(t)
    env = np.zeros_like(t, dtype=float)

    ramp = (t >= 5.0) & (t < 8.0)
    consta = (t>= 8.0) & (t < 15.0)

    env[ramp] = A * (t[ramp] - 5.0) / 3.0
    env[consta] = A

    return env


def drive(t):

    amp = envelope(np.array([t]))[0]

    return amp * np.sin(omegad * t)

# ============================================================
# VAN DER POL OSCILLATOR
#
# x'' - μ(1-x²)x' + ω₀²x = F(t)
# ============================================================

def vdp_driven(t, y):

    x, v = y

    dxdt = v

    dvdt = (
        mu * (1.0 - x**2) * v
        - omega0**2 * x
        + drive(t)
    )

    return [dxdt, dvdt]

def linear_oscillator(t, y):

    x, v = y

    F = (
        F1_amp * np.sin(omega1*t)
        +
        envelope(np.array([t]))[0]
        * F2_amp
        * np.sin(omega2*t)
    )

    dxdt = v

    dvdt = (
        F
        - 2*zeta*omegaL*v
        - omegaL**2*x
    )

    return [dxdt, dvdt]



# ============================================================
# SIMULATION
# ============================================================

t = np.arange(0, duration, 1/fs)

y0 = [0.1, 0.0]

sol = solve_ivp(
    vdp_driven,
    (0, duration),
    y0,
    t_eval=t,
    method="RK45",
    rtol=1e-8,
    atol=1e-10
)

if not sol.success:
    raise RuntimeError(sol.message)

x = sol.y[0]


sol_lin = solve_ivp(
    linear_oscillator,
    (0, duration),
    [0.0, 0.0],
    t_eval=t,
    rtol=1e-8,
    atol=1e-10
)

y_lin = sol_lin.y[0]


# ============================================================
# DRIVING FORCE FOR DISPLAY
# ============================================================

F = envelope(t) * np.sin(omegad * t)

if np.max(np.abs(F)) > 0:
    F_scaled = (
        F / np.max(np.abs(F))
        * np.max(np.abs(x))
    )
else:
    F_scaled = F

# ============================================================
# SPECTROGRAM
# ============================================================

f_spec, t_spec, Sxx = spectrogram(
    x,
    fs=fs,
    window="hann",
    nperseg=1024*4,
    noverlap=1024*.9*4,
    scaling="density",
    mode="psd"
)

Sxx_db = 10 * np.log10(Sxx + 1e-12)


f_lin_spec, t_lin_spec, S_lin = spectrogram(
    y_lin,
    fs=fs,
    window="hann",
    nperseg=1024,
    noverlap=900,
    scaling="density",
    mode="psd"
)

S_lin_db = 10*np.log10(S_lin + 1e-12)



# ============================================================
# FIGURE (8:10 ASPECT RATIO)
# ============================================================

#fig = plt.figure(figsize=(8, 10))
fig1 = plt.figure(figsize=(8,10))
fig2 = plt.figure(figsize=(8,10))


ax_wave = plt.subplot(2, 1, 1)
ax_spec = plt.subplot(2, 1, 2)

ax_wave2 = fig2.add_subplot(2,1,1)
ax_spec2 = fig2.add_subplot(2,1,2)

# ============================================================
# TOP PANEL
# ============================================================

window = 4.0

ymax = 1.1 * max(
    np.max(np.abs(x)),
    np.max(np.abs(F_scaled))
)

ax_wave.set_ylim(-ymax, ymax)
ax_wave.set_xlim(0, window)

ax_wave.set_title(
    "Driven Van der Pol Oscillator"
)

ax_wave.set_ylabel("Amplitude")
ax_wave.grid(True)

force_line, = ax_wave.plot(
    [],
    [],
    color="lightgray",
    lw=4,
    label="Driving force"
)

osc_line, = ax_wave.plot(
    [],
    [],
    color="red",
    lw=2,
    label="Oscillator"
)

cursor_wave = ax_wave.axvline(
    0,
    color="black",
    linestyle="--",
    lw=1
)

time_text = ax_wave.text(
    0.02,
    0.92,
    "",
    transform=ax_wave.transAxes,
    fontsize=12
)

ax_wave.legend(loc=3)



drive1 = F1_amp*np.sin(omega1*t)

drive2 = (
    envelope(t)
    * F2_amp
    * np.sin(omega2*t)
)

combined_drive = drive1 + drive2

drive_line2, = ax_wave2.plot(
    [],
    [],
    color="lightgray",
    lw=2,    
    label="Combined drive"
)

osc_line2, = ax_wave2.plot(
    [],
   *[],
    color="red",
    lw=1.5,
    label="Linear oscillator"
)






# ============================================================
# SPECTROGRAM PANEL
# ============================================================

initial_spec = np.full_like(Sxx_db, np.nan)

mesh = ax_spec.pcolormesh(
    t_spec,
    f_spec,
    initial_spec,
    shading="auto",
    cmap="viridis",
    vmin=np.percentile(Sxx_db, 0),
    vmax=np.percentile(Sxx_db, 100)
)

ax_spec.set_xlim(0, duration)
ax_spec.set_ylim(0, 8)

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


mesh2 = ax_spec2.pcolormesh(
    t_lin_spec,
    f_lin_spec,
    np.full_like(S_lin_db, np.nan),
    shading="auto",
    cmap="viridis"
)

ax_spec2.set_ylim(0,10)




# ============================================================
# ANIMATION
# ============================================================

samples_per_frame = 40

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
        mesh,
        time_text
    )

def update(frame):

    idx = min(
        frame * samples_per_frame,
        len(t) - 1
    )

    t_now = t[idx]

    # --------------------------------------------------------
    # SCROLLING WAVEFORM
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

    cursor_wave.set_xdata(
        [t_now, t_now]
    )

    time_text.set_text(
        f"Time = {t_now:.2f} s"
    )


    drive_line2.set_data(
        t[:idx],
        combined_drive[:idx]
    )

    osc_line2.set_data(
        t[:idx],
        y_lin[:idx]
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

    mesh.set_array(
        spec_visible.ravel()
    )

    cursor_spec.set_xdata(
        [t_now, t_now]
    )

    return (
        force_line,
        osc_line,
        cursor_wave,
        cursor_spec,
        mesh,
        time_text
    )

    visible_lin = t_lin_spec <= t_now

    spec_lin = np.full_like(
        S_lin_db,
        np.nan
    )

    spec_lin[:, visible_lin] = (
        S_lin_db[:, visible_lin]
    )

    mesh2.set_array(
        spec_lin.ravel()
    )



# ============================================================
# CREATE ANIMATION
# ============================================================

ani = FuncAnimation(
    fig1,
    update,
    frames=len(t) // samples_per_frame,
    init_func=init,
    interval=30,
    blit=False
)

plt.tight_layout()

# ============================================================
# SAVE GIF
# ============================================================

#

print("Saving GIF...")

ani.save(
    "../vids/van_der_pol_19s.gif",
    writer=PillowWriter(fps=10)
)

print("GIF saved as van_der_pol_driven_19s.gif")

plt.show()