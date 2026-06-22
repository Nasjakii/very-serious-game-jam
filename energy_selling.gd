extends Control

@export var h_box_container: HBoxContainer 
@export var exit_button: TextureButton
@export var sell_label: Label 
@export var sell_button: TextureButton

var progress_bars : Array[ProgressBar]
var wheel : Node2D
var game_manager : Node
var sell_price = 0

var max_value = 150
var min_value = 50

func _ready() -> void:
	wheel = get_tree().get_first_node_in_group("Wheel")
	game_manager = get_tree().get_first_node_in_group("GameManager")
	hide()
	
	for child in h_box_container.get_children():
		progress_bars.append(child)
		child.max_value = max_value
	
	exit_button.pressed.connect(_on_exit_button_pressed)
	sell_button.pressed.connect(_on_sell_button_pressed)
	
	change_prices()
	
func _on_exit_button_pressed():
	hide()

func _on_sell_button_pressed():
	var wattage = wheel.reset_wattage()
	game_manager.money += sell_price * wattage


func change_prices():
	
	for bar_index in range(progress_bars.size() - 1):
		progress_bars[bar_index].value = progress_bars[bar_index].value
		
	sell_price= randi_range(min_value, max_value)
	progress_bars[-1].value = sell_price

	sell_label.text = str(int(sell_price)) + "HB/W"
