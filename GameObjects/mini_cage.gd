extends Node2D

@export var mini_cage_sprite_2d: Sprite2D
@export var mini_cage_area_2d: Area2D 


var cage_hovered = false
var mini_cage_window : Control = null

func _ready() -> void:
	mini_cage_window = get_tree().get_first_node_in_group("MiniCageWindow")
	
	mini_cage_area_2d.mouse_entered.connect(func(): 
		cage_hovered = true
		mini_cage_sprite_2d.material.set("shader_parameter/color", Color.WHITE)
		
		)
	mini_cage_area_2d.mouse_exited.connect(func(): 
		cage_hovered = false
		mini_cage_sprite_2d.material.set("shader_parameter/color", Color.TRANSPARENT)
		)
	

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
		if cage_hovered and not GameManager.hamster_busy:
			mini_cage_window.show()
			GameManager.hamster_busy = true
