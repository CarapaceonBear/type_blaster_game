from encodings import utf_8
from re import X
import os
import shutil

os.chdir("C:/Users/Will/Documents/Actual Documents/Godot/type_blaster/word_lists")
print(os.getcwd())

# put name of file to be fixed
working_file = "wordlist.txt"
# save a copy, just in case
copy_file = "copy.txt"
shutil.copyfile(working_file, copy_file)

# clear any previous attempts
if os.path.exists("three-four.txt"):
    os.remove("three-four.txt")
if os.path.exists("five-six.txt"):
    os.remove("five-six.txt")
if os.path.exists("seven-plus.txt"):
    os.remove("seven-plus.txt")

with open("copy.txt", "r", encoding = "utf_8") as f:
    # read file to list of strings
    contents = f.readlines()

    # blank list of strings for writing to new file
    writingThreeFour = []
    writingFiveSix = []
    writingSevenPlus = []

    i = 0
    while i < len(contents):
        word = contents[i]
        wordLength = len(word)
        if wordLength > 3 and wordLength <= 5:
            writingThreeFour.append(word)
        elif wordLength > 5 and wordLength <= 7:
            writingFiveSix.append(word)
        elif wordLength > 7:
            writingSevenPlus.append(word)
        i += 1
    
    with open("three-four.txt", "w", encoding = "utf_8") as x:
        x.write("".join(writingThreeFour))
        x.close()
    with open("five-six.txt", "w", encoding = "utf_8") as y:
        y.write("".join(writingFiveSix))
        y.close()
    with open("seven-plus.txt", "w", encoding = "utf_8") as z:
        z.write("".join(writingSevenPlus))
        z.close()
f.close()