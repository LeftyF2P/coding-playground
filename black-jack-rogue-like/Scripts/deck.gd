extends Node2D
class_name Deck


@export var deck_count = 5


# Set the variables used for each card
var suits = ["H", "D", "C", "S"]
var values = ["A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"]
var cards = []


# This is just to test these functions and will be deleted later
func _ready():
	create_deck(5)
	shuffle_deck()


# Function to actually create the full shoe with the number of decks
func create_deck(num_decks := 1):
	cards.clear()
	for i in range(num_decks):
		for suit in suits:
			for value in values:
				cards.append(Card.new(value, suit))


# Function to shuffle the full deck
func shuffle_deck():
	cards.shuffle()


# Deal out the specified number of cards to the hand given
func deal_card() -> Card:
	if cards.is_empty():
		push_warning("Deck is empty - reshuffling")
		create_deck(deck_count)
	
	return cards.pop_back()
