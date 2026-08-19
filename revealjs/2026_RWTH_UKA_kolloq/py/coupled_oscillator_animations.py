
import numpy as np
import matplotlib.pyplot as plt
from matplotlib.animation import FuncAnimation, PillowWriter
from scipy.integrate import solve_ivp
from scipy.signal import spectrogram

# PARAMETERS

duration = 19.0
fs = 1000
f0 = 5.0
fd = 6.0
omega0 = 2*np.pi*f0
omegad = 2*np.pi*fd
mu = 3.0
A = 800.0

fL = 5.0
zeta = 0.02
omegaL = 2*np.pi*fL
omega1 = 2*np.pi*6.0
F1_amp = 10.0
F2_amp = 6.0

samples_per_frame = 20
window = 4.0


def envelope(t):
    t = np.asarray(t)
    env = np.zeros_like(t, dtype=float)
    ramp = (t >= 5.0) & (t < 8.0)
    consta = (t >= 8.0) & (t < 15.0)
    env[ramp] = A * (t[ramp] - 5.0) / 3.0
    env[consta] = A
    return env

def envelopelin(t):
    t = np.asarray(t)
    env = np.zeros_like(t, dtype=float)
    ramp = (t >= 5.0) & (t < 8.0)
    consta = (t >= 8.0) & (t < 15.0)
    env[ramp] = F1_amp * (t[ramp] - 5.0) / 3.0
    env[consta] = F1_amp
    return env



def drive(t):
    return envelope(np.array([t]))[0] * np.sin(omegad*t)


def vdp_driven(t, y):
    x, v = y
    return [v, mu*(1-x**2)*v - omega0**2*x + drive(t)]


def linear_oscillator(t, y):
    x, v = y
    F =  F1_amp*np.sin(omegaL*t) + envelopelin(np.array([t]))[0]*F2_amp*np.sin(omega1*t)
    return [v, F - 2*zeta*omegaL*v - omegaL**2*x]


t = np.arange(0, duration, 1/fs)

sol = solve_ivp(vdp_driven, (0, duration), [0.1, 0], t_eval=t, rtol=1e-8, atol=1e-10)
sol_lin = solve_ivp(linear_oscillator, (0, duration), [0, 0], t_eval=t, rtol=1e-8, atol=1e-10)

x = sol.y[0]
y_lin = sol_lin.y[0]

F = envelope(t)*np.sin(omegad*t)
F_scaled = F/np.max(np.abs(F))*np.max(np.abs(x)) if np.max(np.abs(F))>0 else F

f_spec, t_spec, Sxx = spectrogram(x, fs=fs, window='hann', nperseg=4096, noverlap=3686)
Sxx_db = 10*np.log10(Sxx+1e-12)

f_lin_spec, t_lin_spec, S_lin = spectrogram(y_lin, fs=fs, window='hann', nperseg=4096, noverlap=3686)
S_lin_db = 10*np.log10(S_lin+1e-12)

print(np.max(S_lin_db))

fig1 = plt.figure(figsize=(4,5))
axw1 = fig1.add_subplot(2,1,1)
axs1 = fig1.add_subplot(2,1,2)


force_line, = axw1.plot([], [], color='gray', label = "Driving force")
osc_line, = axw1.plot([], [], color='red', label = "Oscillator")
cursor1 = axw1.axvline(0, color='k', ls='--')
text1 = axw1.text(0.02,0.92,'', transform=axw1.transAxes)

#mesh1 = axs1.pcolormesh(t_spec, f_spec, np.full_like(Sxx_db,np.nan), shading='auto')
vmin_vdp = np.percentile(Sxx_db, 0)
vmax_vdp = np.percentile(Sxx_db, 100)

mesh1 = axs1.pcolormesh(
    t_spec,
    f_spec,
    np.full_like(Sxx_db, np.nan),
    shading='auto',
    cmap='inferno',
    vmin=vmin_vdp,
    vmax=vmax_vdp
)

scursor1 = axs1.axvline(
    0,
    color='cyan',
    lw=2
)

cbar1 = plt.colorbar(
    mesh1,
    ax=axs1
)

cbar1.set_label("Power (dB)")





scursor1 = axs1.axvline(0,color='w')

print(np.max(F_scaled))

axw1.set_ylim(-1.1*max(np.max(np.abs(x)), np.max(np.abs(F_scaled))), 1.1*max(np.max(np.abs(x)), np.max(np.abs(F_scaled))))
axw1.set_title("Driven van der Pol oscillator")
axw1.set_ylabel("Amplitude (normalized)")
axw1.grid(True)

axs1.set_xlim(0,duration); axs1.set_ylim(3,8)


axs1.set_xlabel("Time (s)")
axs1.set_ylabel("Frequency (Hz)")
#axs1.set_title("Spectrogram")
axw1.legend(loc=3)

axw1.set_yticks([0])
axs1.set_xticks([1,5,8, 15])
axs1.set_yticks([5,6,10])



fig2 = plt.figure(figsize=(4,5))
axw2 = fig2.add_subplot(2,1,1)
axs2 = fig2.add_subplot(2,1,2)
combined = envelopelin(t)*F1_amp*np.sin(omega1*t)/F1_amp*np.max(y_lin)
drive_line2, = axw2.plot([], [], color='gray', label="Driving force ")
osc_line2, = axw2.plot([], [], color='red', label = "Oscillator (driven)")
cursor2 = axw2.axvline(0,color='k',ls='--')
text2 = axw2.text(0.02,0.92,'', transform=axw2.transAxes)

#mesh2 = axs2.pcolormesh(t_lin_spec, f_lin_spec, np.full_like(S_lin_db,np.nan), shading='auto')
vmin_lin = np.percentile(S_lin_db, 0)
vmax_lin = np.percentile(S_lin_db, 100)

mesh2 = axs2.pcolormesh(
    t_lin_spec,
    f_lin_spec,
    np.full_like(S_lin_db, np.nan),
    shading='auto',
    cmap='inferno',
    vmin=vmin_lin,
    vmax=vmax_lin
)

scursor2 = axs2.axvline(
    0,
    color='cyan',
    lw=2
)

cbar2 = plt.colorbar(
    mesh2,
    ax=axs2
)

cbar2.set_label("Power (dB)")


axs2.set_xlabel("Time (s)")
axs2.set_ylabel("Frequency (Hz)")
#axs2.set_title("Spectrogram")



scursor2 = axs2.axvline(0,color='w')
axw2.set_ylim(-1.1*max(np.max(np.abs(y_lin)), np.max(np.abs(y_lin))), 1.1*max(np.max(np.abs(y_lin)), np.max(np.abs(y_lin))))
axw2.set_title("Driven linear oscillator")
axw2.grid(True)
axw2.set_yticks([0])
axw2.set_ylabel("Amplitude (normalized)")

axs2.set_xlim(0,duration); axs2.set_ylim(3,10)
axs2.set_xticks([1,5,8, 15])
axs2.set_yticks([5,6,10])

axw2.legend(loc=3)


def update_vdp(frame):
    idx=min(frame*samples_per_frame,len(t)-1)
    now=t[idx]
    left=max(0,now-window); right=min(duration,left+window)
    axw1.set_xlim(left,right)
    force_line.set_data(t[:idx],F_scaled[:idx])
    osc_line.set_data(t[:idx],x[:idx])
    cursor1.set_xdata([now,now]); scursor1.set_xdata([now,now])
    vis=t_spec<=now
    tmp=np.full_like(Sxx_db,np.nan); tmp[:,vis]=Sxx_db[:,vis]
    mesh1.set_array(tmp.ravel())
    text1.set_text(f'Time={now:.2f}s')
    return force_line,osc_line


def update_lin(frame):
    idx=min(frame*samples_per_frame,len(t)-1)
    now=t[idx]
    left=max(0,now-window); right=min(duration,left+window)
    axw2.set_xlim(left,right)
    drive_line2.set_data(t[:idx],combined[:idx]/np.max(combined)*np.max(y_lin))
    osc_line2.set_data(t[:idx],y_lin[:idx])
    cursor2.set_xdata([now,now]); scursor2.set_xdata([now,now])
    vis=t_lin_spec<=now
    tmp=np.full_like(S_lin_db,np.nan); tmp[:,vis]=S_lin_db[:,vis]
    mesh2.set_array(tmp.ravel())
    text2.set_text(f'Time={now:.2f}s')
    return drive_line2,osc_line2

ani_vdp=FuncAnimation(fig1, update_vdp, frames=len(t)//samples_per_frame)
ani_lin=FuncAnimation(fig2, update_lin, frames=len(t)//samples_per_frame)

ani_vdp.save('../vids/van_der_pol_19s.gif', writer=PillowWriter(fps=33))
ani_lin.save('../vids/linear_oscillator_19s.gif', writer=PillowWriter(fps=33))
