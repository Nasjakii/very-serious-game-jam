extends Control

@export var h_box_container: HBoxContainer 
@export var exit_button: TextureButton
@export var sell_label: Label 
@export var sell_button: TextureButton

var progress_bars : Array[ProgressBar]
var wheel : Node2D
var sell_price = 0

var max_value = 0.5
var min_value = 0.25


func _ready() -> void:
	wheel = get_tree().get_first_node_in_group("Wheel")
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
	GameManager.money += sell_price * wattage


func change_prices():
	
	for bar_index in range(progress_bars.size() - 1):
		progress_bars[bar_index].value = progress_bars[bar_index].value
		progress_bars[bar_index].day_label.text = "Day:" + str(GameManager.day - progress_bars.size() + bar_index + 1)
		
	sell_price= randf_range(min_value, max_value)
	progress_bars[-1].value = sell_price

func _process(delta: float) -> void:
	sell_label.text = str(floor(sell_price*100)/100) + "HB/W = " + str(int(floor(sell_price * wheel.wattage))) + "HB"
