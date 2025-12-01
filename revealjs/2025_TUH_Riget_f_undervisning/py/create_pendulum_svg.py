import math

# Parameters

width, height = 300, 300
pivot_x, pivot_y = 150, 50
bob_x, bob_y = 150, 200
bob_r = 20
string_width = 2
ceiling_width = 4

# Oscillator settings
amplitude_deg = 30.0      # initial amplitude in degrees
gamma = 0.2               # damping coefficient
frequency = 2.25           # Hz
period = 1.0              # seconds
cycles = 20               # number of cycles
duration = cycles * period
frames = 300              # smoothness

filename = "../pics/pendulum_damped_2p25.svg"
filename_reverse = "../pics/pendulum_damped_reverse_2p25.svg"


# Compute angles and keyTimes
times = [i * duration / (frames - 1) for i in range(frames)]
angles = [amplitude_deg * math.exp(-gamma * t) * math.sin(2 * math.pi * frequency * t) for t in times]
values_entries = [f"{angle:.4f} {pivot_x} {pivot_y}" for angle in angles]
values_attr = "; ".join(values_entries)

values_entries_reverse = [f"{angle:.4f} {pivot_x} {pivot_y}" for angle in angles[::-1]]
values_attr_reverse = "; ".join(values_entries_reverse)
keytimes_attr = ";".join(f"{i/(frames-1):.6f}" for i in range(frames))

# Build SVG content - damped
svg_content = f'''<?xml version="1.0" encoding="UTF-8"?>
<svg width="{width}" height="{height}" xmlns="http://www.w3.org/2000/svg">
  <!-- Ceiling -->
  <line x1="{pivot_x}" y1="20" x2="{pivot_x}" y2="{pivot_y}" stroke="black" stroke-width="{ceiling_width}"/>
  
  <!-- Pendulum -->
  <g>
    <line x1="{pivot_x}" y1="{pivot_y}" x2="{bob_x}" y2="{bob_y}" stroke="black" stroke-width="{string_width}"/>
    <circle cx="{bob_x}" cy="{bob_y}" r="{bob_r}" fill="#77000083" stroke="black" stroke-width="2"/>
    <animateTransform attributeName="transform" attributeType="XML"
      type="rotate"
      values="{values_attr}"
      keyTimes="{keytimes_attr}"
      dur="{duration}s"
      repeatCount="indefinite"
      begin="0s"/>
  </g>
</svg>
'''

# Save file
with open(filename, "w", encoding="utf-8") as f:
    f.write(svg_content)

# Build SVG content - undamped
svg_content_reverse = f'''<?xml version="1.0" encoding="UTF-8"?>
<svg width="{width}" height="{height}" xmlns="http://www.w3.org/2000/svg">
  <!-- Ceiling -->
  <line x1="{pivot_x}" y1="20" x2="{pivot_x}" y2="{pivot_y}" stroke="black" stroke-width="{ceiling_width}"/>
  
  <!-- Pendulum -->
  <g>
    <line x1="{pivot_x}" y1="{pivot_y}" x2="{bob_x}" y2="{bob_y}" stroke="black" opacity=".5" stroke-width="{string_width}"/>
    <circle cx="{bob_x}" cy="{bob_y}" r="{bob_r}" fill="#77000083" stroke="black" stroke-width="2"/>
    <animateTransform attributeName="transform" attributeType="XML"
      type="rotate"
      values="{values_attr_reverse}"
      keyTimes="{keytimes_attr}"
      dur="{duration}s"
      repeatCount="indefinite"
      begin="0s"/>
  </g>
</svg>
'''

# Save file
with open(filename_reverse, "w", encoding="utf-8") as f:
    f.write(svg_content_reverse)



print(f"SVG file '{filename}' created successfully!")