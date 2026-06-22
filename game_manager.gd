extends Node


var food_amount = 1
var food_amount_max = 1
var food_loss = 0.01

var energy_amount = 10
var energy_amount_max = 10
var energy_loss = 0.01

var water_amount = 100
var water_amount_max = 100
var water_loss = 0.01

var social_amount = 1
var social_amount_max = 1
var social_loss = 0.0

var money = 0

var day = 0

var black_screen : ColorRect
var time_hbox : HBoxContainer

func _ready() -> void:
	time_hbox = get_tree().get_first_node_in_group("TimeHBox")
	time_hbox.day_end.connect(_on_day_end)
	black_screen = get_tree().get_first_node_in_group("BlackScreen")
	#black_screen.fade_in(3)
	#await black_screen.finished
	black_screen.fade_out(5)
	
func _on_day_end():
	day += 1
	black_screen.set_day(day)
	black_screen.fade_in(1)
	await black_screen.finished
	black_screen.fade_out(5)


func _process(delta: float) -> void:
	food_amount -= 0.001
