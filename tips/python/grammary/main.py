from random import randrange
def grammary(): 
    verbs=[]
    verbs.append([["love", "loves"], "loved"])
    verbs.append([["go", "goes"], "went"])
    do_verb=[["do", "does"], "did"]
    mass=["I","you", "they", "we", "he", "she"]
    RANDOM=randrange(5)
    if RANDOM == 1:
        pronoun=mass[randrange(len(mass))]
        verb=verbs[randrange(len(verbs))]
        if pronoun in ["he", "she"]:
            statement=pronoun + ' ' + verb[0][1]
        else:
            statement=pronoun + ' ' + verb[0][0]
        statement=statement[0].upper() + statement[1:]
        print(statement)
    if RANDOM == 0:
        pronoun=mass[randrange(len(mass))]
        verb=verbs[randrange(len(verbs))]
        if pronoun in ["he", "she"]:
            statement=do_verb[0][1]  + ' ' + pronoun + ' ' + verb[0][0]
        else:
            statement=do_verb[0][0]  + ' ' + pronoun + ' ' + verb[0][0]
        statement=statement[0].upper() + statement[1:]
        print(statement)
    if RANDOM == 3:
        pronoun=mass[randrange(len(mass))]
        verb=verbs[randrange(len(verbs))]
        statement= pronoun + ' ' + verb[1]
        statement=statement[0].upper() + statement[1:]
        print(statement)
    if RANDOM == 4:
        pronoun=mass[randrange(len(mass))]
        verb=verbs[randrange(len(verbs))]
        statement=do_verb[1]  + ' ' + pronoun + ' ' + verb[0][0]
        statement=statement[0].upper() + statement[1:]
        print(statement)
for i in range(0,10):
    grammary()