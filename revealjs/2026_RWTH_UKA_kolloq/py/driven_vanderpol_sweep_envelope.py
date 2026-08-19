import numpy as np
import matplotlib.pyplot as plt
from scipy.integrate import solve_ivp
from scipy.signal import chirp, hilbert
import matplotlib.animation as animation
from scipy.io.wavfile import write

# Parameters
f0 = 500  # natural frequency in Hz
omega0 = 2 * np.pi * f0
mu = 5
duration = 10.0  # seconds
fs = 44100  # sampling frequency
t = np.linspace(0, duration, int(fs * duration))
win_len = .1

# Driving force: chirp with fade-in and fade-out
chirp_signal = chirp(t, f0=480, f1=540, t1=duration, method='linear')
window = np.ones_like(t)

#window[:fs] = np.linspace(0, 1, fs)  # fade-in over 1 second
#window[-fs:] = np.linspace(1, 0, fs)  # fade-out over 1 second

window[:int(np.fix(win_len*fs))] = np.linspace(0, 1, int(fs*win_len))  # fade-in over 1 second
window[-int(np.fix(win_len*fs)):] = np.linspace(1, 0, int(fs*win_len))  # fade-out over 1 second

driving_force = 500000*chirp_signal * window

# Van der Pol oscillator ODE with driving force
def vdp_driven(t, y):
    x, dx = y
    force = np.interp(t, t_vals, driving_force)
    ddx = mu * (1 - x**2) * dx - omega0**2 * x + force
    #ddx = -50 * dx - omega0**2 * x + force
    return [dx, ddx]

# Solve ODE
t_vals = t
y0 = [2.0, 0.0]
sol = solve_ivp(vdp_driven, [0, duration], y0, t_eval=t_vals, method='RK45')
x = sol.y[0]


# Normalize oscillator amplitude to fit in int16 range for WAV
x_normalized = x / np.max(np.abs(x))
x_int16 = np.int16(x_normalized * 32767)

# Save as WAV file
write('oscillator_output.wav', fs, x_int16)
print("Saved oscillator amplitude as 'oscillator_output.wav'")




plt.plot(x)
plt.show()

plt.figure()
# Hilbert envelope
envelope = np.abs(hilbert(x))

# Normalize all curves to max amplitude of 1
x_norm = x / np.max(np.abs(x))
driving_force_norm = driving_force / np.max(np.abs(driving_force))
envelope_norm = envelope / np.max(np.abs(envelope))
sum_signal_norm = (x + driving_force*0) / np.max(np.abs(x + driving_force*0))

# Animation setup
window_size = int(0.1 * fs)  # 100 ms window
fig, ax = plt.subplots(figsize=(10, 5))
line1, = ax.plot([], [], label='Oscillator + Driving Force', color='blue')
line2, = ax.plot([], [], label='Driving Force', color='orange')
line3, = ax.plot([], [], label='Hilbert Envelope', color='green')
ax.set_xlim(0, 0.1)
ax.set_ylim(-1.1, 1.1)
ax.set_xlabel('Time [s]')
ax.set_ylabel('Normalized Amplitude')
ax.set_title('Driven Van der Pol Oscillator Animation')
ax.legend()
ax.grid(True)

def init():
    line1.set_data([], [])
    line2.set_data([], [])
    line3.set_data([], [])
    return line1, line2, line3

def update(frame):
    start = frame * window_size
    end = start + window_size
    if end > len(t_vals):
        end = len(t_vals)
    t_window = t_vals[start:end] - t_vals[start]
    line1.set_data(t_window, sum_signal_norm[start:end])
    line2.set_data(t_window, driving_force_norm[start:end])
    line3.set_data(t_window, envelope_norm[start:end])
    return line1, line2, line3

#num_frames = len(t_vals) // window_size
#ani = animation.FuncAnimation(fig, update, frames=num_frames, init_func=init, blit=True)

# Save animation as GIF
#ani.save('../vids/vdp_driven_animation.gif', writer='pillow', fps=10)
#print("Animation saved as 'vdp_driven_animation.gif'")
