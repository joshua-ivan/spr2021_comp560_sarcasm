from num2words import num2words
import os

def getdb():
    with open('SentiWordNet_3.0.0.txt', 'r') as db:
        result = db.readlines()
        db.close()
        return result
        
def get_entries(fact_base):
    kb = []
    
    for line in fact_base:
        info = line.split()
        
        if fact_base.index(line) > 0:
            if len(info) > 1:
                fact_data = []
                
                for word in info:
                    if word.find('#') > -1:
                        fact_data.append(word)
                
                for value in fact_data:
                    kb.append((info[0], value, info[2], info[3]))
    return kb
    
def prologify(facts):
    pldb = []
    
    for entry in facts:
        fact_type = entry[0]
        
        if fact_type == 'a':
            proper_entry = remove_illegal_syntax(entry[1])
            pldb.append('adjective(' + '\"' + proper_entry + '\"' + ', ' + entry[2] + ', ' + entry[3] + ').')
        elif fact_type == 'n':
            proper_entry = remove_illegal_syntax(entry[1])
            pldb.append('noun(' + '\"' + proper_entry + '\"' + ', ' + entry[2] + ', ' + entry[3] + ').')
        elif fact_type == 'r':
            proper_entry = remove_illegal_syntax(entry[1])
            pldb.append('adverb(' + '\"' + proper_entry + '\"' + ', ' + entry[2] + ', ' + entry[3] + ').')
        elif fact_type == 's':
            proper_entry = remove_illegal_syntax(entry[1])
            pldb.append('adjective_satellite(' + '\"' + proper_entry + '\"' + ', ' + entry[2] + ', ' + entry[3] + ').')
        else:
            proper_entry = remove_illegal_syntax(entry[1])
            pldb.append('verb(' + '\"' + proper_entry + '\"' + ', ' + entry[2] + ', ' + entry[3] + ').')
        
    return pldb
    
def remove_illegal_syntax(code):
    legal_code = trim_end(code)
    legal_code = legal_code.replace('#', '')
    return legal_code
    
def trim_end(target):
    if not target[len(target) - 1].isdigit():
        return target
    else:
        return trim_end(target[:len(target) - 1])
def find_largest_number(num_str):
    if len(num_str) > 0:
        if num_str[0].isdigit():
            return num_str[0] + find_largest_number(num_str[1:])
        else:
            return ""
    else:
        return ""

def prune_knowledge_base():
    kb = open('sentiword.pl', 'r')
    fact_lst = kb.readlines()
    result = set(fact_lst)
    kb.close()
    
    os.remove('sentiword.pl')
    sorted_res = list(result)
    sorted_res.sort()
    
    with open('sentiword.pl', 'w') as prolog:
        prolog.write(':- consult(\'definitions\').\n\n')
        for line in sorted_res:
            prolog.write(line)
    prolog.close()
    
def generate_prolog(kb):   
    with open('sentiword.pl', 'w') as prolog:
        for line in kb:
            prolog.write(line + '\n')
    prolog.close()
    
db = getdb()
facts = get_entries(db)
prolog_facts = prologify(facts)
generate_prolog(prolog_facts)
prune_knowledge_base()

with open('defn.py', 'r') as prog:
    exec(prog.read())
    prog.close()
