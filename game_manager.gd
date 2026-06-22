extends Node

@export var money_rich_text_label : RichTextLabel = null

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

var money : int = 0 : 
	get: 
		return money 
	set(value): 
		money = value
		money_rich_text_label.text = str(value)


var day = 0

var black_screen : ColorRect
var time_hbox : HBoxContainer
var energy_selling : Control

func _ready() -> void:
	energy_selling = get_tree().get_first_node_in_group("EnergySelling")
	time_hbox = get_tree().get_first_node_in_group("TimeHBox")
	time_hbox.day_end.connect(_on_day_end)
	black_screen = get_tree().get_first_node_in_group("BlackScreen")
	#black_screen.fade_in(3)
	#await black_screen.finished
	black_screen.fade_out(5)
	
func _on_day_end():
	day += 1
	
	energy_selling.change_prices()
	
	
	black_screen.set_day(day)
	black_screen.fade_in(1)
	await black_screen.finished
	black_screen.fade_out(5)


func _process(delta: float) -> void:
	food_amount -= 0.001
