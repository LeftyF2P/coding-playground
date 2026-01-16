extends Node2D
class_name Hand

# Initial Variables
var cards = []
var score = 0


# Add card to hand
func add_card(card: Card):
	cards.append(card)
	score = score_hand()


# Remove a card from the hand
# Mostly used in splitting but think about maybe adding a power to do this
func remove_card(card: Card):
	cards.erase(card)


# Clear Hand
func clear():
	cards.clear()


# Score Hand
func score_hand() -> int:
	var total = 0
	
	# Adjust total and account for aces
	for card in cards:
		if card.rank != "A":
			total += card.value
		elif total + 11 > 21:
			total += 1
		else:
			total += 11
	
	return total


# Determine if the hand is able to be split
func is_splittable() -> bool:
	# Exactly 2 cards AND they must have the same rank
	if cards.size() != 2:
		return false
	return cards[0].rank == cards[1].rank
