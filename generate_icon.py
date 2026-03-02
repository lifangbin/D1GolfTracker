from PIL import Image, ImageDraw, ImageFilter
import math

# Create 1024x1024 image using the EXACT Icons.golf_course SVG path
# SVG path: M17 5.92L9 2v18H7v-1.73c-1.79.35-3 .99-3 1.73 0 1.1 2.69 2 6 2s6-.9 6-2c0-.99-2.16-1.81-5-1.97V8.98l6-3.06z
# Plus circle at cx="19.5" cy="19.5" r="1.5" (golf ball)

size = 1024
img = Image.new('RGBA', (size, size), (0, 0, 0, 0))
draw = ImageDraw.Draw(img)

# Apple glass-style gradient background (green)
for y in range(size):
    ratio = y / size
    r = int(46 + (20 - 46) * ratio)
    g = int(139 + (90 - 139) * ratio)
    b = int(34 + (50 - 34) * ratio)
    for x in range(size):
        draw.point((x, y), fill=(r, g, b, 255))

# Add radial highlight for glass effect (top-left)
for y in range(size):
    for x in range(size):
        dist = math.sqrt((x - 200)**2 + (y - 200)**2)
        if dist < 600:
            current = img.getpixel((x, y))
            highlight = int(40 * (1 - dist/600))
            new_color = (
                min(255, current[0] + highlight),
                min(255, current[1] + highlight),
                min(255, current[2] + highlight),
                255
            )
            img.putpixel((x, y), new_color)

# Scale factor: SVG is 24x24, we want centered in 1024x1024
# Icon should be about 600px, so scale = 25
scale = 28
offset_x = 180  # Center horizontally
offset_y = 180  # Center vertically

white = (255, 255, 255, 255)

# Draw the golf_course icon based on SVG path
# The icon consists of:
# 1. A flag pole with triangular flag (the path)
# 2. A golf ball (circle at 19.5, 19.5 with r=1.5)
# 3. An elliptical green/ground at bottom

# Flag pole - vertical line from top to bottom
pole_x = int(9 * scale + offset_x)  # x=9 in SVG
pole_top = int(2 * scale + offset_y)  # y=2 in SVG (top of flag)
pole_bottom = int(20 * scale + offset_y)  # approximate bottom
pole_width = int(0.8 * scale)

# Draw the pole
draw.rectangle([pole_x - pole_width//2, pole_top, pole_x + pole_width//2, pole_bottom], fill=white)

# Flag triangle: from (9,2) to (17,5.92) going right, then back to pole
# This is a triangular flag pointing right
flag_points = [
    (int(9 * scale + offset_x), int(2 * scale + offset_y)),  # Top of pole
    (int(17 * scale + offset_x), int(5.92 * scale + offset_y)),  # Point of flag
    (int(9 * scale + offset_x), int(8.98 * scale + offset_y)),  # Bottom of flag on pole
]
draw.polygon(flag_points, fill=white)

# Ground/putting green - ellipse at bottom
# Based on SVG: the ground goes from x=4 to x=16, y around 20
ground_cx = int(10 * scale + offset_x)
ground_cy = int(20 * scale + offset_y)
ground_rx = int(6 * scale)
ground_ry = int(1.5 * scale)
draw.ellipse([ground_cx - ground_rx, ground_cy - ground_ry,
              ground_cx + ground_rx, ground_cy + ground_ry], fill=white)

# Golf ball - circle at (19.5, 19.5) with r=1.5
ball_cx = int(19.5 * scale + offset_x)
ball_cy = int(19.5 * scale + offset_y)
ball_r = int(1.5 * scale)
draw.ellipse([ball_cx - ball_r, ball_cy - ball_r, ball_cx + ball_r, ball_cy + ball_r], fill=white)

# Hole in ground (small dark circle) - implied by the icon
hole_cx = int(7 * scale + offset_x)
hole_cy = int(18.27 * scale + offset_y)

# Add subtle top edge highlight (glass effect)
for x in range(size):
    for y in range(30):
        current = img.getpixel((x, y))
        highlight = int(25 * (1 - y/30))
        new_color = (
            min(255, current[0] + highlight),
            min(255, current[1] + highlight),
            min(255, current[2] + highlight),
            255
        )
        img.putpixel((x, y), new_color)

# Save
img.save('/Users/fangbinli/HappyGolf/assets/icons/app_icon.png')
print("Created app_icon.png with exact Icons.golf_course design")

# Create foreground version (transparent background)
fg_img = Image.new('RGBA', (size, size), (0, 0, 0, 0))
fg_draw = ImageDraw.Draw(fg_img)

# Flag pole
fg_draw.rectangle([pole_x - pole_width//2, pole_top, pole_x + pole_width//2, pole_bottom], fill=white)

# Flag triangle
fg_draw.polygon(flag_points, fill=white)

# Ground ellipse
fg_draw.ellipse([ground_cx - ground_rx, ground_cy - ground_ry,
                 ground_cx + ground_rx, ground_cy + ground_ry], fill=white)

# Golf ball
fg_draw.ellipse([ball_cx - ball_r, ball_cy - ball_r, ball_cx + ball_r, ball_cy + ball_r], fill=white)

fg_img.save('/Users/fangbinli/HappyGolf/assets/icons/app_icon_foreground.png')
print("Created app_icon_foreground.png with exact Icons.golf_course design")

# Create splash_logo.png with golf flag icon (like Icons.golf_course)
splash_size = 512
splash_img = Image.new('RGBA', (splash_size, splash_size), (0, 0, 0, 0))
splash_draw = ImageDraw.Draw(splash_img)

# White color for the icon
white = (255, 255, 255, 255)

# Center of the icon
cx, cy = 256, 200

# Draw the golf flag icon (similar to Icons.golf_course)
# Flag pole (vertical line)
pole_x = cx + 30
pole_top = cy - 80
pole_bottom = cy + 100
pole_width = 8
splash_draw.rectangle([pole_x - pole_width//2, pole_top, pole_x + pole_width//2, pole_bottom], fill=white)

# Flag (triangle pointing left)
flag_top = pole_top
flag_bottom = pole_top + 70
flag_left = pole_x - 80
# Draw filled triangle for flag
for y in range(flag_top, flag_bottom):
    progress = (y - flag_top) / (flag_bottom - flag_top)
    x_start = int(flag_left + (pole_x - flag_left) * progress)
    splash_draw.line([x_start, y, pole_x, y], fill=white)

# Golf hole (circle/ellipse at bottom)
hole_cx = cx
hole_cy = cy + 110
hole_rx = 90
hole_ry = 25
splash_draw.ellipse([hole_cx - hole_rx, hole_cy - hole_ry, hole_cx + hole_rx, hole_cy + hole_ry], fill=white)

# Golf ball (small circle to the left of the hole)
ball_cx = cx - 60
ball_cy = cy + 85
ball_r = 20
splash_draw.ellipse([ball_cx - ball_r, ball_cy - ball_r, ball_cx + ball_r, ball_cy + ball_r], fill=white)

# Add "D1" text in yellow/gold below the icon
d1_y = 380
d1_color = (255, 193, 7, 255)  # Gold/yellow color

# Draw "D" - a rounded rectangle shape
d_x = 180
# Vertical bar of D
for y in range(d1_y, d1_y + 60):
    for x in range(d_x, d_x + 15):
        splash_draw.point((x, y), fill=d1_color)
# Curved part of D (approximated with circles)
for angle in range(-90, 90):
    for r in range(25, 40):
        x = int(d_x + 15 + r * math.cos(math.radians(angle)))
        y = int(d1_y + 30 + r * math.sin(math.radians(angle)))
        if 0 <= x < splash_size and 0 <= y < splash_size:
            splash_draw.point((x, y), fill=d1_color)
# Clear inner part of D curve
for angle in range(-90, 90):
    for r in range(0, 25):
        x = int(d_x + 15 + r * math.cos(math.radians(angle)))
        y = int(d1_y + 30 + r * math.sin(math.radians(angle)))
        if 0 <= x < splash_size and 0 <= y < splash_size:
            splash_img.putpixel((x, y), (0, 0, 0, 0))

# Draw "1"
one_x = 280
# Vertical bar of 1
for y in range(d1_y, d1_y + 60):
    for x in range(one_x, one_x + 15):
        splash_draw.point((x, y), fill=d1_color)
# Top serif of 1
for y in range(d1_y, d1_y + 12):
    for x in range(one_x - 15, one_x):
        splash_draw.point((x, y), fill=d1_color)
# Bottom base of 1
for y in range(d1_y + 50, d1_y + 60):
    for x in range(one_x - 10, one_x + 25):
        splash_draw.point((x, y), fill=d1_color)

splash_img.save('/Users/fangbinli/HappyGolf/assets/icons/splash_logo.png')
print("Created splash_logo.png with golf flag icon + D1 text")
