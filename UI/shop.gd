extends Control

@export var toggle_shop_button : TextureButton

var ui_canvas : CanvasLayer

func _ready() -> void:
	ui_canvas = get_tree().get_first_node_in_group("UI")
	
	toggle_shop_button.pressed.connect(ui_canvas.toggle_shop)
