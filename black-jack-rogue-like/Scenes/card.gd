extends Node2D
class_name Card

# Initial Variables
@export var rank: String
@export var suit: String

var value: int


# Called when the node enters the scene tree for the first time.
func _init(_rank := "A", _suit := "S"):
	rank = _rank
	suit = _suit
	value = get_blackjack_value()


# Get the blackjack value of the card
func get_blackjack_value() -> int:
	
	if rank.is_valid_int():
		return int(rank)
	
	if rank in ["J", "Q", "K"]:
		return 10
	
	if rank == "A":
		return 11
	
	push_error("Invalid rank : %s" % rank)
	return 0
