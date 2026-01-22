import time
import pydirectinput
import keyboard
import random
import re

# Set the min and max time spent on a single game in seconds
rand_min = 1
rand_max = 5

# Get the user's number of save states they want to use
while True:
    try:
        print('How many save states do you want to run? (MAX 8)')
        num_of_saves = input()
        if re.findall('[a-zA-Z]', num_of_saves):
            print('You entered a value with a letter. Please enter a number.')
        elif int(num_of_saves) > 8:
            print("You entered a number greater than 8. Please enter a number less than 9.")
        else:
            break
    except:
        break

saves_going = []

# Loop through the number of saves submitted by user
for i in range(1, (int(num_of_saves) + 1)):
    save = 'f' + str(i)
    saves_going.append(save)
    print('Please get to the start of race ' + str(i) + ' and press Shift F' + str(i))
    keyboard.wait('shift+' + save)
    print('Save state has been saved.\n')

# Shuffle the save states
random.shuffle(saves_going)
previous_save = saves_going[0]

# Start the racing
print ('Now back out to the main menu and press space bar to start the races.\n')
keyboard.wait('space')
pydirectinput.press(previous_save)
print('Starting on race ' + previous_save + '\n')

# Loop through and press save states if enough time has passed
duration = time.time() + rand_max
while len(saves_going) > 1: 
    try:
        # Check if the duration has passed and if so switch to a new race
        if time.time() >= duration:
            previous_save = saves_going[0]
            random.shuffle(saves_going)
            
            if saves_going[0] == previous_save:
                previous_save = saves_going[1]

            pydirectinput.keyDown('shift')
            pydirectinput.press(previous_save)
            pydirectinput.keyUp('shift')
            print('Switching to race ' + previous_save + '\n')
            pydirectinput.press(previous_save)
            
            duration = time.time() + random.randint(rand_min,rand_max)
        
        # Check if a race has finished and if so then end it and switch to a new race
        if keyboard.is_pressed('space'):
            pydirectinput.keyDown('shift')
            pydirectinput.press(previous_save)
            pydirectinput.keyUp('shift')
            print('Race ' + previous_save + ' has finished\n')
            saves_going.remove(previous_save)

            if len(saves_going) > 1:
                random.shuffle(saves_going)
                print('Switching to race ' + saves_going[0] + '\n')
                pydirectinput.press(saves_going[0])
                duration = time.time() + random.randint(3,9)
            else:
                break
        
        # Cancel the race early
        if keyboard.is_pressed('esc'):
            print('Games have been canceled.')
            quit()
    except:
        break

pydirectinput.press(saves_going[0])
print('You are on the final race.\n')
keyboard.wait('space')
print('You have finished all races!')
