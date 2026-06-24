extends Node2D

@export var dispenser_sprite_2d: Sprite2D

@export var dispenser_area_2d: Area2D

var dispenser_hovered = false
var drink_selection : Control = null

func _ready() -> void:
	drink_selection = get_tree().get_first_node_in_group("DrinkSelection")
	
	dispenser_area_2d.mouse_entered.connect(func(): 
		dispenser_hovered = true
		dispenser_sprite_2d.material.set("shader_parameter/color", Color.WHITE)
		
		)
	dispenser_area_2d.mouse_exited.connect(func(): 
		dispenser_hovered = false
		dispenser_sprite_2d.material.set("shader_parameter/color", Color.TRANSPARENT)
		)
	

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
		if dispenser_hovered and not GameManager.hamster_busy:
			drink_selection.show()
			GameManager.hamster_busy = true
