extends Node2D

@export var hay_sprite_2d: Sprite2D
@export var hay_area_2d: Area2D

var hay_hovered = false
var sleep_controller : Control

func _ready() -> void:
	sleep_controller = get_tree().get_first_node_in_group("SleepController")
	hay_area_2d.mouse_entered.connect(func(): 
		hay_hovered = true
		hay_sprite_2d.material.set("shader_parameter/color", Color.WHITE)
		
		)
	hay_area_2d.mouse_exited.connect(func(): 
		hay_hovered = false
		hay_sprite_2d.material.set("shader_parameter/color", Color.TRANSPARENT)
		)
	


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		if hay_hovered:
			sleep_controller.show()
