# LOOKUP TABLE GENERATOR

import math

# implementing Q3.13 fixed point arithmetic (fixed point arithmetic is subject to change)
fractional_bits = 13
iterations = 16

print(f"{'i':<3}{'Angle (rad)':<18}{'Fixed-Point':<15}{'Hex'}")

for i in range(iterations):

    angle = math.atan(2 ** (-i)) # computing arctan

    fixed_point = round(angle * (1<<fractional_bits)) # computing fixed point value

    print(f"{i:<3}{angle:<18.12f}{fixed_point:<15}{hex(fixed_point)}") # converting fixed point value to hexadecimal format





