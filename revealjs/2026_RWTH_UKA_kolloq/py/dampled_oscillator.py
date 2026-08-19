import numpy as np
import matplotlib.pyplot as plt
from matplotlib.patches import Circle
from matplotlib.animation import FuncAnimation, PillowWriter

# ==========================================================
# Parameters
# ==========================================================

FREQ = 5.0          # Hz
DAMPING = 0.05 / FREQ      # damping ratio
A = 1               # impulse amplitude
T_PULSE = 2.0       # s
T_END = 12.0        # s
DT = 0.01           # s

FNTSIZE = 22

# ==========================================================
# Simulate damped harmonic oscillator
#
# x'' + 2*zeta*omega*x' + omega^2*x = 0
#
# Impulse applied at t=1 s by adding velocity A
# ==========================================================

omega = 2 * np.pi * FREQ

t = np.arange(0, T_END + DT, DT)

x = np.zeros_like(t)
v = np.zeros_like(t)

pulse_idx = np.argmin(np.abs(t - T_PULSE))

# velocity jump from impulse
v[pulse_idx] += A

for i in range(pulse_idx, len(t) - 1):

    a = (
        -2 * DAMPING * omega * v[i]
        - omega**2 * x[i]
    )

    v[i + 1] = v[i] + a * DT
    x[i + 1] = x[i] + v[i + 1] * DT

# ==========================================================
# Figure setup
# 15 cm x 10 cm
# ==========================================================

cm = 1 / 2.54

fig, (ax_pendulum, ax_signal) = plt.subplots(
    1,
    2,
    figsize=(15 * cm, 10 * cm),
    gridspec_kw={"width_ratios": [1, 1.4]},
)

# ==========================================================
# Left panel : Pendulum
# ==========================================================

L = 2.0
theta_max = np.deg2rad(45)

amp_scale = np.max(np.abs(x))
if amp_scale == 0:
    amp_scale = 1.0

# pulse background
pulse_time = np.linspace(0, T_END, 1000)
pulse_signal = A * np.exp(-((pulse_time - T_PULSE) / 0.05) ** 2)

pulse_x = -1.35 + 0.6 * pulse_time / T_END
pulse_y = 1.10 + 0.32 * pulse_signal

#ax_pendulum.plot(
#    pulse_x,
#    pulse_y,
#    color="lightcoral",
#    linewidth=3,
#    alpha=0.7,
#)

circle = Circle(
    (0, 0),
    L,
    fill=False,
    linestyle="--",
    color="gray",
    linewidth=1.5,
)
#ax_pendulum.add_patch(circle)

pivot = ax_pendulum.plot(
    0,
    0,
    "ko",
    markersize=6,
)[0]

rod, = ax_pendulum.plot(
    [],
    [],
    color="navy",
    linewidth=3,
)

mass, = ax_pendulum.plot(
    [],
    [],
    "o",
    color="crimson",
    markersize=12,
)

time_text = ax_pendulum.text(
    -1.4,
    -1.3,
    "",
    fontsize=10,
)

ax_pendulum.set_aspect("equal")
ax_pendulum.set_xlim(-1.7, 1.7)
ax_pendulum.set_ylim(-2.3, .1)
#ax_pendulum.set_title("Pendulum Representation")
ax_pendulum.axis("off")

# ==========================================================
# Right panel : Signal history
# ==========================================================

ax_signal.plot(
    t,
    x,
    color="lightblue",
    linewidth=1,
)

ax_signal.axvline(
    T_PULSE,
    color="gray",
    linestyle="-",
    linewidth=4,
    label="Impulse",
)

history_line, = ax_signal.plot(
    [],
    [],
    color="navy",
    linewidth=2,
)

current_point, = ax_signal.plot(
    [],
    [],
    "ro",
)

ax_signal.set_xlim(0, T_END)

margin = 0.05
ax_signal.set_ylim(
    np.min(x) - margin,
    np.max(x) + margin,
)

ax_signal.set_xlabel("Time", fontsize=FNTSIZE)
ax_signal.set_ylabel("Amplitude", fontsize=FNTSIZE)
#ax_signal.set_title("Damped harmonic oscillator")
ax_signal.grid(True, alpha=0.3)
#ax_signal.legend()

ax_signal.set_xticks([])
ax_signal.set_yticks([])

ax_signal.spines['top'].set_visible(False)
ax_signal.spines['left'].set_visible(False)
ax_signal.spines['right'].set_visible(False)
ax_signal.spines['bottom'].set_visible(False)

# ==========================================================
# Animation
# ==========================================================

frame_step = 2
frame_indices = np.arange(0, len(t), frame_step)

def update(frame_index):

    theta = theta_max * x[frame_index] / amp_scale

    px = L * np.sin(theta)
    py = -L * np.cos(theta)

    rod.set_data(
        [0, px],
        [0, py]
    )

    mass.set_data(
        [px],
        [py]
    )

    history_line.set_data(
        t[:frame_index + 1],
        x[:frame_index + 1]
    )

    current_point.set_data(
        [t[frame_index]],
        [x[frame_index]]
    )

    #time_text.set_text(
    #    f"t = {t.2f} s"
    #)

    return (
        rod,
        mass,
        history_line,
        current_point,
        time_text,
    )

animation = FuncAnimation(
    fig,
    update,
    frames=frame_indices,
    interval=20,
    blit=True,
)

plt.tight_layout()

print("Saving GIF...")

animation.save(
    "../vids/damped_harmonic_oscillator_5.gif",
    writer=PillowWriter(fps=30),
)

print("Saved: damped_harmonic_oscillator.gif")

plt.show()