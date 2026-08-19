import numpy as np
import matplotlib.pyplot as plt
from scipy.integrate import solve_ivp
from matplotlib.animation import FuncAnimation, PillowWriter

# ==========================================================
# Forced Van der Pol oscillator with ramped driving force
# ==========================================================

# Van der Pol parameters
mu = 2.0

# Drive parameters
A_max = 1.0      # maximum drive amplitude
f_drive = 1.0    # drive frequency [Hz]

# Timing parameters
t_end = 12.0
T1 = 2.0         # drive starts ramping up
T2 = 5.0         # drive reaches full amplitude

fps = 30

# ==========================================================
# Driving-force envelope
# ==========================================================

def drive_amplitude(t):
    """
    Piecewise amplitude envelope:

    0           for t < T1
    linear ramp for T1 <= t < T2
    A_max       for T2 <= t < t_end - 1
    0           during last second
    """

    if t < T1:
        return 0.0

    elif t < T2:
        return A_max * (t - T1) / (T2 - T1)

    elif t < (t_end - 1.0):
        return A_max

    else:
        return 0.0


# ==========================================================
# Forced Van der Pol equation
# ==========================================================

def vdp_forced(t, y):
    x, v = y

    A_t = drive_amplitude(t)
    force = A_t * np.sin(2 * np.pi * f_drive * t)

    dxdt = v
    dvdt = mu * (1 - x**2) * v - 10*x + force

    return [dxdt, dvdt]


# ==========================================================
# Solve ODE
# ==========================================================

t_eval = np.linspace(0, t_end, int(fps * t_end))

sol = solve_ivp(
    vdp_forced,
    [0, t_end],
    [0.1, 0.0],      # initial conditions
    t_eval=t_eval,
    rtol=1e-8,
    atol=1e-8
)

t = sol.t
x = sol.y[0]

# Driving force for plotting
driving_force = np.array([
    drive_amplitude(ti) * np.sin(2 * np.pi * f_drive * ti)
    for ti in t
])

# Envelope for visualization
envelope = np.array([
    drive_amplitude(ti)
    for ti in t
])

# ==========================================================
# Create animation
# ==========================================================

plt.rcParams.update({
    "font.size": 14,
    "axes.labelsize": 18,
    "legend.fontsize": 12
})

fig, ax = plt.subplots(figsize=(10, 5))

ax.set_xlim(0, t_end)
ax.set_ylim(-3, 3)

ax.set_xlabel("time [s]")
ax.set_ylabel("amplitude / a.u.")

line_vdp, = ax.plot(
    [],
    [],
    color="#d7191c",
    lw=2.5,
    label="Van der Pol Oscillator"
)

line_drive, = ax.plot(
    [],
    [],
    color="gray",
    lw=2.0,
    label="Driving Force"
)

# Optional envelope visualization
line_env, = ax.plot(
    [],
    [],
    "--",
    color="black",
    alpha=0.4,
    lw=1.5,
    label="Drive Envelope"
)

ax.legend(loc="upper left")


# ==========================================================
# Animation functions
# ==========================================================

def init():
    line_vdp.set_data([], [])
    line_drive.set_data([], [])
    line_env.set_data([], [])
    return line_vdp, line_drive, line_env


def update(frame):
    line_vdp.set_data(t[:frame], x[:frame])
    line_drive.set_data(t[:frame], driving_force[:frame])
    line_env.set_data(t[:frame], envelope[:frame])

    return line_vdp, line_drive, line_env


anim = FuncAnimation(
    fig,
    update,
    frames=len(t),
    init_func=init,
    interval=1000 / fps,
    blit=True
)

# ==========================================================
# Save GIF
# ==========================================================

anim.save(
    "van_der_pol_entrainment.gif",
    writer=PillowWriter(fps=fps)
)

plt.show()