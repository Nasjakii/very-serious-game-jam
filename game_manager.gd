extends Node


var food_amount = 1
var food_amount_max = 1
var energy_amount = 10
var energy_amount_max = 10
var water_amount = 100
var water_amount_max = 100
var social_amount = 1
var social_amount_max = 1

var money = 0

var black_screen : ColorRect

func _ready() -> void:
	black_screen = get_tree().get_first_node_in_group("BlackScreen")
	#black_screen.fade_in(3)
	#await black_screen.finished
	black_screen.fade_out(5)
	
