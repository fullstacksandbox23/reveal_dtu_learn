import numpy as np
import matplotlib.pyplot as plt
from matplotlib.animation import FuncAnimation, PillowWriter

# ==========================================================
# Parameters
# ==========================================================

FREQ = 1.0        # Hz
MU = 2.0          # Van der Pol nonlinearity
A = 1.0           # impulse amplitude

T_PULSE = 2.0     # s
T_END = 12.0      # s
DT = 0.01         # s

FNTSIZE = 22


# ==========================================================
# Van der Pol oscillator
#
# x'' - mu(1-x²)x' + omega²x = 0
#
# State variables:
# x = displacement
# v = velocity
# ==========================================================

omega = 2 * np.pi * FREQ

t = np.arange(0, T_END + DT, DT)

x = np.zeros_like(t)
v = np.zeros_like(t)

pulse_idx = np.argmin(np.abs(t - T_PULSE))

# impulse excitation
v[pulse_idx] += A


def rhs(x, v):
    """
    Right-hand side of the Van der Pol oscillator.
    """

    dxdt = v
    dvdt = MU * (1.0 - x**2) * v - omega**2 * x

    return dxdt, dvdt


# ----------------------------------------------------------
# RK4 integration
# ----------------------------------------------------------

for i in range(pulse_idx, len(t) - 1):

    k1x, k1v = rhs(
        x[i],
        v[i]
    )

    k2x, k2v = rhs(
        x[i] + 0.5 * DT * k1x,
        v[i] + 0.5 * DT * k1v
    )

    k3x, k3v = rhs(
        x[i] + 0.5 * DT * k2x,
        v[i] + 0.5 * DT * k2v
    )

    k4x, k4v = rhs(
        x[i] + DT * k3x,
        v[i] + DT * k3v
    )

    x[i + 1] = x[i] + DT / 6.0 * (
        k1x + 2 * k2x + 2 * k3x + k4x
    )

    v[i + 1] = v[i] + DT / 6.0 * (
        k1v + 2 * k2v + 2 * k3v + k4v
    )

# ==========================================================
# Figure setup
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

amp_scale = np.percentile(np.abs(x), 99)

if amp_scale < 1e-8:
    amp_scale = 1.0

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
    -1.6,
    -2.15,
    "",
    fontsize=10,
)

ax_pendulum.set_aspect("equal")
ax_pendulum.set_xlim(-1.7, 1.7)
ax_pendulum.set_ylim(-2.3, 0.1)
ax_pendulum.axis("off")

# ==========================================================
# Right panel : Time history
# ==========================================================

ax_signal.plot(
    t,
    x,
    color="lightblue",
    linewidth=1.5,
)

ax_signal.axvline(
    T_PULSE,
    color="gray",
    linestyle="--",
    linewidth=2,
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

margin = 0.1

ax_signal.set_ylim(
    np.min(x) - margin,
    np.max(x) + margin,
)

ax_signal.set_xlabel("Time", fontsize= FNTSIZE)
ax_signal.set_ylabel("Amplitude", fontsize= FNTSIZE)

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

frame_indices = np.arange(
    0,
    len(t),
    frame_step,
)


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

 #   time_text.set_text(
 #       f"t = {t.2f} s"
 #   )

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
    "../vids/van_der_pol_oscillator_1.gif",
    writer=PillowWriter(fps=30),
)

print("Saved: van_der_pol_oscillator.gif")

plt.show()