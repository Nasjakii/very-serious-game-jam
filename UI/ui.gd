extends CanvasLayer

@export var shop: Control
@export var ui_audio: AudioStreamPlayer

@export var dispenser : Node2D
@export var water_plant : Node2D

var shop_open = false 


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("OpenShop"):
		toggle_shop()
		
		dispenser.dispenser_hovered = false
		dispenser.dispenser_sprite_2d.material.set("shader_parameter/color", Color.TRANSPARENT)
		
		water_plant.water_plant_sprite_2d.material.set("shader_parameter/color", Color.TRANSPARENT)
		water_plant.plant_hovered = false
		


func toggle_shop():
	
	ui_audio.toggle_shop()
	
	if shop_open:
		var tween = get_tree().create_tween()
		tween.tween_property(shop, "position:x", -shop.size.x, 0.2).from(0)
		#tween.tween_callback(shop.hide)
	else:
		#shop.show()
		var tween = get_tree().create_tween()
		tween.tween_property(shop, "position:x", 0, 0.2).from(-shop.size.x)
		
	shop_open = not shop_open
