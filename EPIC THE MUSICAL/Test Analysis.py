import os

folder = r"Songs"

word_to_search = "what?"
song_count = 1
word_count = 0

for filename in os.listdir(folder):
    song = open(folder + "/" + filename, encoding="utf-8")
    lyrics = song.read().lower()
    
    count = lyrics.count(word_to_search)
    word_count += count
    #print(filename)
    print("The question What? is found " + str(count) + " times in song " + str(song_count))
    
    song_count += 1

print()
print("What? Was asked a total of " + str(word_count) + " times.")
