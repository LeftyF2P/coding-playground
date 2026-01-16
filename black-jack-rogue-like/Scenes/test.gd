extends Node2D


@onready var deck: Deck = Deck.new()
@onready var player_hands: Array = []
@onready var dealer_hand: Hand = Hand.new()

var game_over := false


func _ready():
	add_child(deck)
	add_child(dealer_hand)
	start_new_round()


func start_new_round():
	game_over = false
	deck.create_deck(10)
	deck.shuffle_deck()
	player_hands.clear()
	dealer_hand.clear()

	# Deal two cards each
	var first_hand := Hand.new()
	player_hands.append(first_hand)
	first_hand.add_card(deck.deal_card())
	dealer_hand.add_card(deck.deal_card())
	first_hand.add_card(deck.deal_card())
	dealer_hand.add_card(deck.deal_card())

	print("Player's Hand:")
	print(first_hand.cards[0].rank + first_hand.cards[0].suit + ", " + first_hand.cards[1].rank + first_hand.cards[1].suit)
	print("Player's Score: " + str(first_hand.score))
	print()
	print("Dealer's Hand")
	print(dealer_hand.cards[0].rank + dealer_hand.cards[0].suit + ", " + dealer_hand.cards[1].rank + dealer_hand.cards[1].suit)
	print("Dealer's Score: " + str(dealer_hand.score))
	# Check immediate blackjack
	#	if player_hand.has_blackjack() or dealer_hand.has_blackjack():
	#	conclude_round()


func player_hit():
	if game_over:
		return

	player_hands[0].add_card(deck.deal_card())

	if player_hands[0].is_bust():
		conclude_round()


func player_stand():
	if game_over:
		return

	dealer_play()
	conclude_round()


func dealer_play():
	# Dealer hits on < 17
	while dealer_hand.score_hand() < 17:
		dealer_hand.add_card(deck.deal_card())


func conclude_round():
	game_over = true

	var player_total = player_hands[0].score_hand()
	var dealer_total = dealer_hand.score_hand()

	var result: String = ""

	if player_hands[0].is_bust():
		result = "Player Busts — Dealer Wins!"
	elif dealer_hand.is_bust():
		result = "Dealer Busts — Player Wins!"
	elif player_hands[0].has_blackjack() and not dealer_hand.has_blackjack():
		result = "Player Blackjack!"
	elif dealer_hand.has_blackjack() and not player_hands[0].has_blackjack():
		result = "Dealer Blackjack!"
	else:
		if player_total > dealer_total:
			result = "Player Wins!"
		elif dealer_total > player_total:
			result = "Dealer Wins!"
		else:
			result = "Push (Tie)"

	print("--- ROUND RESULT ---")
	print("Player:", player_total)
	print("Dealer:", dealer_total)
	print(result)
	print("--------------------")
