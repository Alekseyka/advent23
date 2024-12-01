file = open("2/input", "r")


def parse_game(string):
    game = []
    game_number = int(string[string.find("Game ") + 5 : string.find(":")])
    draws = string[string.find(":") + 1 : :].split(";")
    for draw in draws:
        comb_to_writ = {}
        for combination in draw.split(","):
            combination = combination.lstrip().split(" ")
            comb_to_writ[combination[1]] = int(combination[0])
        game.append(comb_to_writ)
    return game_number, game


def is_game_possible(game, bag):
    for draw in game:
        for key in draw:
            if draw[key] > bag[key]:
                return False
    return True


def part1():
    bag = {"red": 12, "green": 13, "blue": 14}
    answer = 0
    for line in file:
        game_number, game = parse_game(line.rstrip())
        if is_game_possible(game, bag) == True:
            answer += game_number
    return answer

def part2():
    answer = 0
    for line in file:
        bag_min = {"red": 0, "green":0, "blue": 0}
        draws = line.rstrip()[line.find(":") + 1 : :].split(";")
        for draw in draws:
            for combination in draw.split(","):
                combination = combination.lstrip().split(" ")
                if bag_min[combination[1]] < int(combination[0]):
                    bag_min[combination[1]] = int(combination[0])
        answer += bag_min["red"]*bag_min["blue"]*bag_min["green"]
    return answer

print(part2())
