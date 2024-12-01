from collections import Counter

first_column = []
second_column = []

def a():
    with open("input_a") as file:
        for line in file:
            line = line.strip('\n').split(sep = '   ')
            first_column.append(int(line[0]))
            second_column.append(int(line[1]))

    sorted_first_column = sorted(first_column)
    sorted_second_column = sorted(second_column)

    distance = 0
    for i in range(len(sorted_first_column)):
        print(sorted_first_column[i])
        distance += abs(sorted_first_column[i] - sorted_second_column[i])

    print(distance)

def b():
    with open("input_a") as file:
        for line in file:
            line = line.strip('\n').split(sep = '   ')
            first_column.append(int(line[0]))
            second_column.append(int(line[1]))
    
    counted_second_column = Counter(second_column)
    similarity_score = 0
    
    for num in first_column:
        similarity_score += num * counted_second_column[num]
   
    print(similarity_score)