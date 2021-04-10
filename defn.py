from num2words import num2words


def find_largest_number(num_str):
    if len(num_str) > 0:
        if num_str[0].isdigit():
            return num_str[0] + find_largest_number(num_str[1:])
        else:
            return ""
    else:
        return ""

db = open('SentiWordNet_3.0.0.txt', 'r')
data = db.readlines()
db.close()
definitions = []

for line in data[1:]:
    word_info = line.split('\t')[4:]
    
    synonyms = []
    
    for text in word_info:
        if text.find('#') > -1:
            synonyms.append(text[:text.index('#')])
        else:
            for word in synonyms:
                definitions.append((word, text.replace('\n', '')))

definitions.sort()

with open('definitions.pl', 'w') as kb:
    for defn in definitions:
        if defn[1] == "":
            continue
        if not defn[0].isnumeric():
            kb.write('definition(' + '"' + defn[0] + '"' + ', ' + '"' + str(defn[1].replace('"', '')) + '"' + ').\n')
    kb.close()