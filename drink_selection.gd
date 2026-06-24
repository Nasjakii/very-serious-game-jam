extends Control

@export var drink_h_box_container: HBoxContainer
@export var exit_button: TextureButton
@export var water_button: TextureButton
@export var energy_button: TextureButton
@export var drink_action_button : TextureButton

var energy_count = 0
var drink_buttons : Array[TextureButton]
var drink_selected = -1

var bar_container_manager : Control = null

func _ready() -> void:
	bar_container_manager = get_tree().get_first_node_in_group("BarContainerManager")
	hide()
	exit_button.pressed.connect(_on_exit_button_pressed)
	drink_action_button.pressed.connect(_on_drink_action_pressed)
	
	water_button.pressed.connect(_on_drink_select.bind(0))
	energy_button.pressed.connect(_on_drink_select.bind(1))
	
	for child in drink_h_box_container.get_children():
		drink_buttons.append(child)


func _on_exit_button_pressed():
	hide()
	GameManager.hamster_busy = false


func _on_drink_select(type : int):
	reset_selection()
	match type:
		0:
			water_button.material.set("shader_parameter/color", Color.WHITE)
			bar_container_manager.set_below_values(0, 10, 10, 0)
		1:
			energy_button.material.set("shader_parameter/color", Color.WHITE)
		
	
func add_drink(drink_name : String):
	print(drink_name)
		

func reset_selection():
	bar_container_manager.set_below_values(-100, -100, -100, -100)
	
	for drink_button in drink_buttons:
		drink_button.material.set("shader_parameter/color", Color.TRANSPARENT)
		
func _on_drink_action_pressed():
	if drink_selected == -1: return
	if drink_selected == 0:
		pass
