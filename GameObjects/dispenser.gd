extends Node2D

@export var dispenser_sprite_2d: Sprite2D

@export var dispenser_area_2d: Area2D

var dispenser_hovered = false

func _ready() -> void:
	dispenser_area_2d.mouse_entered.connect(func(): 
		dispenser_hovered = true
		dispenser_sprite_2d.material.set("shader_parameter/color", Color.WHITE)
		
		)
	dispenser_area_2d.mouse_exited.connect(func(): 
		dispenser_hovered = false
		dispenser_sprite_2d.material.set("shader_parameter/color", Color.TRANSPARENT)
		)
	
