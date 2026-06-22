extends CanvasLayer

@export var shop: Control

@export var social_bar: TextureProgressBar
@export var energy_bar: TextureProgressBar
@export var water_bar: TextureProgressBar
@export var food_bar: TextureProgressBar



var shop_open = false 




func _input(event: InputEvent) -> void:
	if event.is_action_pressed("OpenShop"):
		toggle_shop()



func toggle_shop():
	if shop_open:
		var tween = get_tree().create_tween()
		tween.tween_property(shop, "position:x", -shop.size.x, 0.2).from(0)
		#tween.tween_callback(shop.hide)
	else:
		#shop.show()
		var tween = get_tree().create_tween()
		tween.tween_property(shop, "position:x", 0, 0.2).from(-shop.size.x)
		
	shop_open = not shop_open
