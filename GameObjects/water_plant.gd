extends Node2D

@export var water_plant_sprite_2d: Sprite2D
@export var water_plant_area_2d: Area2D 


var plant_hovered = false


func _ready() -> void:
	
	water_plant_area_2d.mouse_entered.connect(func(): 
		plant_hovered = true
		water_plant_sprite_2d.material.set("shader_parameter/color", Color.WHITE)
		
		)
	water_plant_area_2d.mouse_exited.connect(func(): 
		plant_hovered = false
		water_plant_sprite_2d.material.set("shader_parameter/color", Color.TRANSPARENT)
		)
	

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
		if plant_hovered and not GameManager.hamster_busy:
			GameManager.hamster_busy = true
			await get_tree().create_timer(4).timeout
			GameManager.hamster_busy = false
