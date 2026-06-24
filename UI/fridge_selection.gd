extends Control

@export var food_h_box_container: HBoxContainer
@export var exit_button: TextureButton
@export var buttons: Array[TextureButton]
@export var eat_action_button : TextureButton

var energy_count = 0
var food_buttons : Array[TextureButton]
var food_selected = -1

var bar_container_manager : Control = null

func _ready() -> void:
	bar_container_manager = get_tree().get_first_node_in_group("BarContainerManager")
	hide()
	exit_button.pressed.connect(_on_exit_button_pressed)
	eat_action_button.pressed.connect(_on_eat_action_pressed)
	
	for child in food_h_box_container.get_children():
		buttons.append(child)
	
	for i in range(buttons.size()):
		buttons[i].pressed.connect(_on_food_select.bind(i))

	
	for child in food_h_box_container.get_children():
		food_buttons.append(child)


func _on_exit_button_pressed():
	hide()
	GameManager.hamster_busy = false


func _on_food_select(type : int):
	reset_selection()

	buttons[type].material.set("shader_parameter/color", Color.WHITE)
	
	match type:
		0:
			bar_container_manager.set_below_values(0, 10, 10, 0)
		1:
			pass
		2:
			pass
		3:
			pass
		4:
			pass

func add_food(food_name : String):
	print(food_name)

		

func reset_selection():
	bar_container_manager.set_below_values(-100, -100, -100, -100)
	
	for food_button in food_buttons:
		food_button.material.set("shader_parameter/color", Color.TRANSPARENT)
		
func _on_eat_action_pressed():
	if food_selected == -1: return
	if food_selected == 0:
		pass
