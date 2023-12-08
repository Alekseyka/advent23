

def is_key_ends_with_A(pair):
    key, value = pair
    if key[-1] == "A":
        return True
    else:
        return False
   
def check_all_positions(positions):
    for position in positions:
        if position[-1] != "Z":
            return False
    return True
     
file = open("8/input", "r")
numer_of_steps = 0
path = file.readline().rstrip()
file.readline()
path_points = {}

for line in file:
    path_points[line[0:3]] = {"L": line[7:10], "R": line[12:15]}

positions = dict(filter(is_key_ends_with_A, path_points.items()))
print(positions)
print(check_all_positions(positions.keys()))
for step in cycle(path):
    if check_all_positions(positions.keys()) == True:
        break
    new_positions = {}
    for position in positions:
        new_positions[positions.get(position).get(step)] = path_points.get(positions.get(position).get(step))
    positions = new_positions
    numer_of_steps +=1

print(numer_of_steps)
