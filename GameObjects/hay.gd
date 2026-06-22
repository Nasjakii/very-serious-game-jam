extends Node2D

@export var hay_sprite_2d: Sprite2D
@export var hay_area_2d: Area2D

var hay_hovered = false

func _ready() -> void:
	hay_area_2d.mouse_entered.connect(func(): 
		hay_hovered = true
		hay_sprite_2d.material.set("shader_parameter/color", Color.WHITE)
		
		)
	hay_area_2d.mouse_exited.connect(func(): 
		hay_hovered = false
		hay_sprite_2d.material.set("shader_parameter/color", Color.TRANSPARENT)
		)
	
