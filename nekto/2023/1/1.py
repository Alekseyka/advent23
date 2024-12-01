words_to_numbers_forward = {
    "one": 1,
    "two": 2,
    "three": 3,
    "four": 4,
    "five": 5,
    "six": 6,
    "seven": 7,
    "eight": 8,
    "nine": 9,
}
dicts_forward = {
    1: set("otfsen"),
    2: set(["on", "tw", "th", "fo", "fi", "si", "se", "ei", "ni"]),
    3: set(["thr", "fou", "fiv", "sev", "eig", "nin"]),
    "3_full": set(["one", "two", "six"]),
    4: set(["thre", "seve", "eigh"]),
    "4_full": set(["four", "five", "nine"]),
    "5_full": set(["three", "seven", "eight"]),
}

words_to_numbers_backward = {
    "eno": 1,
    "owt": 2,
    "eerht": 3,
    "ruof": 4,
    "evif": 5,
    "xis": 6,
    "neves": 7,
    "thgie": 8,
    "enin": 9,
}
dicts_backward = {
    1: set("eorxnt"),
    2: set(["en", "ow", "ee", "ru", "ev", "xi", "ne", "th", "en"]),
    3: set(["eer", "ruo", "evi", "nev", "thg", "eni"]),
    "3_full": set(["eno", "owt", "xis"]),
    4: set(["eerh", "neve", "thgi"]),
    "4_full": set(["ruof", "evif", "enin"]),
    "5_full": set(["eerht", "neves", "thgie"]),
}

def find_digit_in_line(line: str, dict: dict, words_to_numbers: dict):
    word_length = 0
    word = ""
    for i in line:
        if i.isdigit():
            return int(i)

        word += i
        word_length += 1
        if word in dict.get(str(word_length) + "_full", set()):
            return words_to_numbers[word]
        if word in dict.get(word_length, set()):
            continue

        not_word = word
        word = i
        word_length = len(word)
        for char in not_word[-2::-1]:
            if char + word in dict.get(word_length + 1, set()):
                word = char + word
                word_length = len(word)
                continue
            else:
                break

with open("nekto/1/input") as file:
    doc_checksum = 0
    for line in file:
        line = line.rstrip()
        first_digit = find_digit_in_line(line, dicts_forward, words_to_numbers_forward)
        doc_checksum += first_digit * 10
        last_digit = find_digit_in_line(line[::-1], dicts_backward, words_to_numbers_backward)
        doc_checksum += last_digit

print(doc_checksum)
