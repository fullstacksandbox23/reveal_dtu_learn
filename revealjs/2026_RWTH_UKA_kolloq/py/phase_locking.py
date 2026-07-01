import numpy as np
import matplotlib.pyplot as plt
from matplotlib.colors import LinearSegmentedColormap

# --- Parameters ---
N = 100
r = 1.0
PHI = 30
v = 50

# --- Generate random angles ---
angles_deg = np.random.normal(PHI, v, N)
angles = np.deg2rad(angles_deg)

# --- Convert to Cartesian vectors ---
x = np.cos(angles)
y = np.sin(angles)

# --- Resultant vector ---
sum_x = np.sum(x)
sum_y = np.sum(y)
R = np.sqrt(sum_x**2 + sum_y**2) / N
theta_R = np.arctan2(sum_y, sum_x)

# --- Colormap (red → green) ---
cmap = LinearSegmentedColormap.from_list("rg", ["red", "green"])
arrow_color = cmap(R)

# --- Plot ---
fig = plt.figure(figsize=(6, 6))
ax = fig.add_subplot(111, polar=True)

fig.patch.set_alpha(0)
ax.set_facecolor("none")


# Remove default grid (we’ll draw custom ones)
ax.grid(False)

# --- Custom colored circular ticks ---
num_rings = 30
radii = np.linspace(r / num_rings, R, num_rings)

theta_full = np.linspace(0, 2*np.pi, 500)

for radius in radii:
    norm_val = radius / r  # normalize 0→1
    color = cmap(norm_val)
    ax.plot(theta_full, np.full_like(theta_full, radius),
            color=color, linewidth=5, alpha=0.6)

# --- Plot vectors ---
for angle in angles:
    ax.plot([angle, angle], [0, r], color='black', alpha=0.2, linewidth=3)

# --- Plot resultant vector ---
ax.arrow(theta_R, 0, 0, R * r,
         width=0.03,
         color='black',
         edgecolor=arrow_color,
         linewidth=8,
         length_includes_head=True,
         zorder=1)

# --- Styling ---
ax.set_ylim(0, r)
ax.set_yticklabels([])

#ax.set_title(f"Polar Histogram with Resultant Vector\nR = {R:.2f}", fontsize=12)




plt.savefig("polar_histogram.svg",
            format="svg",
            transparent=True,
            bbox_inches="tight",
            pad_inches=0)

plt.show()