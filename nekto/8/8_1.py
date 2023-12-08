from itertools import cycle

file = open("8/input", "r")
numer_of_steps = 1
path = file.readline().rstrip()
file.readline()
path_points = {}

for line in file:
    path_points[line[0:3]] = {"L": line[7:10], "R": line[12:15]}

next = path_points.get("AAA")
for step in cycle(path):
    if next.get(step) == "ZZZ":
        break
    next = path_points.get(next.get(step))
    numer_of_steps += 1
    
print(numer_of_steps)
