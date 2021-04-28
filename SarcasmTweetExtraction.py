import requests, json, time


def removeFromList(input_list, removeNum):
    for i in range(removeNum):
        try:
            input_list.pop(0)
        except IndexError:
            pass
    return input_list


def getCsvString(input_list, num):
    string = ''
    for i in range(num):
        string += input_list[i] + ','
    return string


def convertStringToList(input_string, separatorCharacter):
    # Convert string to list then iterate through list replacing the new line characters for commas
    character_list = list(input_string)
    return_list = []
    input_string = ''
    for char in character_list:
        if char == separatorCharacter:
            return_list.append(input_string)
            input_string = ''
        else:
            input_string += char

    return return_list


def removeEmojiFromString(input_string):
    return_string = ''
    for char in input_string:
        if len(char.encode()) == 1:
            return_string += char
    return return_string


def removeHastagsAndAtsFromString(input_string):
    return_string = ''
    hashtagStringLength = 0
    for char in input_string:
        if char == '#' or char == '@':
            hashtagStringLength = 1
        elif hashtagStringLength > 0 and (char == ' ' or char == '\n'):
            hashtagStringLength = 0
            return_string += char
        elif hashtagStringLength > 0:
            hashtagStringLength += 1
        else:
            return_string += char
    return return_string


def removeUrlsFromString(input_string):
    return_string = ''
    urlStringLength = 0
    for i in range(len(input_string)):
        if input_string[i] == 'h' and input_string[i+1] == 't' and input_string[i+2] == 't' \
                and input_string[i+3] == 'p':
            urlStringLength += 1
        elif input_string[i] == ' ':
            urlStringLength = 0
            return_string += ' '
        elif urlStringLength > 0:
            urlStringLength += 1
        else:
            return_string += str(input_string[i])
    return return_string


# Get list, always make 1 call then mak remaining calls depending on rateLimit
def getTwitterTextData(id_string):
    url = 'https://api.twitter.com/2/tweets'
    bearerToken = 'Bearer AAAAAAAAAAAAAAAAAAAAAI%2F2OAEAAAAAHm5uUDpUOA1JQYZ2pIQsoTkEJWo%3DI0OjZx69RHdtpJnJ62pmpA00LCvpUtjHn8OwLt2N0Gzfvny2CS'
    querystring = {'ids': id_string}
    headers = {'Authorization': bearerToken}
    response = requests.request('GET', url, headers=headers, params=querystring)
    print(response.status_code)
    if response.status_code != 200:
        return [], 0
    data_dict = json.loads(response.text)
    data_headers = response.headers
    rateLimit = data_headers['x-rate-limit-remaining']
    print('Rate Limit: ' + str(rateLimit))
    data_list = []
    # If there is is a key in the dictionary that is labelled 'data'. Otherwise only 'error' key would exist.
    if 'data' in data_dict:
        data_list = data_dict['data']
    return data_list, rateLimit


def runGetDataLoop(input_list):
    return_list = []
    while len(input_list) > 0:
        csvID_string = convertListToString(input_list[:100], ',')
        data_list, rateLimit = getTwitterTextData(csvID_string)
        input_list = removeFromList(input_list, 100)
        return_list.extend(data_list)
        time.sleep(5)
        if rateLimit == 0:
            break
    return return_list


def convertListToString(input_list, separatorCharacter, dict=False, key=''):
    return_string = ''
    if dict:
        for elem in input_list:
            return_string += elem[key] + separatorCharacter
    else:
        for elem in input_list:
            return_string += elem + separatorCharacter
    return_string = return_string[0:len(return_string)-1]
    return return_string


'''------------------------------------------------------ MAIN ------------------------------------------------------'''
# Get input from file (with statement closes the file when indented code completes)
with open('data/normal.txt', 'r') as file:
    ids_string = file.read()

id_list = convertStringToList(ids_string, '\n')

# Initial run set id_list[:30000] and writing at the end to 'w' instead of 'a'
tweet_list = runGetDataLoop(id_list[0:49999])

# Because the tweet_list is a list of dictionaries need to specify that the list dict=True and the dictionary key
tweet_string = convertListToString(tweet_list, '\n\n\n', True, 'text')
tweet_string = removeHastagsAndAtsFromString(tweet_string)
tweet_string = removeUrlsFromString(tweet_string)
tweet_string = removeEmojiFromString(tweet_string)

# print(tweet_string)     # For testing purposes
with open('data/normalTweets.txt', 'a', encoding='UTF-8') as file:
    file.write(tweet_string)

