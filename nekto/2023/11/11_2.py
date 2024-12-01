input_length = len(open("nekto/11/input", "r").readline())

galaxies_expansion_rate = 1000000
galaxies_coordinates = []
columns_with_galaxies = set()
columns_witout_galaxies = set()
file = open("nekto/11/input", "r")
j = 0


def apply_width_expansion(galaxy: [], columns: set(), expansion_rate: int) -> []:
    number_of_expands = sum(1 for column in columns if column < galaxy[0])
    if number_of_expands > 0:
        galaxy[0] = galaxy[0] + number_of_expands * expansion_rate - 1 * number_of_expands
    return galaxy

for line in file:
    is_galaxy_in_line = False
    i = 0
    for char in line.rstrip():
        if char == "#":
            galaxies_coordinates.append([i, j])
            columns_with_galaxies.add(i)
            is_galaxy_in_line = True
        i += 1
    if is_galaxy_in_line:
        j = j + 1
    else:
        j = j + galaxies_expansion_rate

print(columns_with_galaxies)
print(galaxies_coordinates)

for i in range(0, input_length - 1):
    if i not in columns_with_galaxies:
        columns_witout_galaxies.add(i)
print(columns_witout_galaxies)

galaxies_coordinates_with_width_expansion = []
for galaxy in galaxies_coordinates:
    galaxies_coordinates_with_width_expansion.append(
        apply_width_expansion(galaxy, columns_witout_galaxies, galaxies_expansion_rate)
    )

print(galaxies_coordinates_with_width_expansion)

cumulative_distance_between_galaxies = 0
number_of_pairs = 0
for i in range(0, len(galaxies_coordinates_with_width_expansion) - 1):
    for j in range(1 + i, len(galaxies_coordinates_with_width_expansion)):
        cumulative_distance_between_galaxies += abs(
            galaxies_coordinates_with_width_expansion[i][0]
            - galaxies_coordinates_with_width_expansion[j][0]
        ) + abs(
            galaxies_coordinates_with_width_expansion[i][1]
            - galaxies_coordinates_with_width_expansion[j][1]
        )
        number_of_pairs += 1

print(number_of_pairs)
print(cumulative_distance_between_galaxies)
