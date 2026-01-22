import time
import pydirectinput
import keyboard
import random
import pyautogui
import re


# Set the min and max time spent on a single game in seconds
rand_min = 1
rand_max = 5

# Get the user's number of save states they want to use
num_of_saves = 0
while True:
    try:
        print('How many games do you want to run? (MAX 8)')
        num_of_saves = input()
        if re.findall('[a-zA-Z]', num_of_saves):
            print('You entered a value with a letter. Please enter a number.')
        elif int(num_of_saves) > 8:
            print("You entered a number greater than 8. Please enter a number less than 9.")
        else:
            num_of_saves = int(num_of_saves)
            break
    except:
        break

# Start the racing
print ('Now back out to the main menu and press space bar to start the games.\n')
keyboard.wait('space')
time_start = time.time()
dolphin = pyautogui.getWindowsWithTitle("JIT64")[num_of_saves - 1]
pydirectinput.press('f10')
dolphin.activate()
pydirectinput.press('f10')

# Loop through and press save states if enough time has passed
duration = time.time() + rand_max
while num_of_saves > 1: 
    try:
        # Check if the duration has passed and if so switch to a new race
        if time.time() >= duration:
            dolphin = pyautogui.getWindowsWithTitle("JIT64")[num_of_saves - 1]
            pydirectinput.press('f10')
            dolphin.activate()
            pydirectinput.press('f10')
            
            duration = time.time() + random.randint(rand_min,rand_max)
        
        # Check if a race has finished and if so then end it and switch to a new race
        if keyboard.is_pressed('space'):
            if num_of_saves > 2:
                dolphin = pyautogui.getWindowsWithTitle("JIT64")[num_of_saves - 1]
                pydirectinput.press('f10')
                dolphin.activate()
                pydirectinput.press('f10')
                dolphin = pyautogui.getWindowsWithTitle("JIT64")[num_of_saves - 1]
                pydirectinput.press('f10')
                dolphin.activate()
                pydirectinput.press('f10')
                num_of_saves = num_of_saves - 1
            else:
                dolphin = pyautogui.getWindowsWithTitle("JIT64")[num_of_saves - 1]
                pydirectinput.press('f10')
                dolphin.activate()
                pydirectinput.press('f10')
                num_of_saves = num_of_saves - 1
        
        # Cancel the race early
        if keyboard.is_pressed('esc'):
            print('Games have been canceled.')
            quit()
    except:
        break

print('You are on the final game.\n')
keyboard.wait('space')
print('You have finished all games!')
print('You finished all the games in ' + str(time.time() - time_start) + ' seconds')
