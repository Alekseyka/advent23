from itertools import cycle
from math import lcm

def is_key_ends_with_A(pair):
    key, value = pair
    if key[-1] == "A":
        return True
    else:
        return False
   
file = open("8/input", "r")

path = file.readline().rstrip()
file.readline()
path_points = {}
loop_sizes = []

for line in file:
    path_points[line[0:3]] = {"L": line[7:10], "R": line[12:15]}

positions = dict(filter(is_key_ends_with_A, path_points.items()))
print(positions)
for position in positions:
    numer_of_steps = 0
    for step in cycle(path):
        if position[2] == "Z":
            loop_sizes.append(numer_of_steps)
            break
        position = path_points.get(position).get(step)
        numer_of_steps +=1

print(loop_sizes)
print(lcm(*loop_sizes))
