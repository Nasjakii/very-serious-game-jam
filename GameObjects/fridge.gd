extends Node2D

@export var fridge_sprite_2d: Sprite2D

@export var fridge_area_2d: Area2D

var fridge_hovered = false
var fridge_selection : Control = null

func _ready() -> void:
	fridge_selection = get_tree().get_first_node_in_group("FridgeSelection")
	
	fridge_area_2d.mouse_entered.connect(func(): 
		fridge_hovered = true
		fridge_sprite_2d.material.set("shader_parameter/color", Color.WHITE)
		
		)
	fridge_area_2d.mouse_exited.connect(func(): 
		fridge_hovered = false
		fridge_sprite_2d.material.set("shader_parameter/color", Color.TRANSPARENT)
		)
	

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
		if fridge_hovered and not GameManager.hamster_busy:
			fridge_selection.show()
			GameManager.hamster_busy = true
