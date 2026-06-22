extends Control

@export var drink_hbox_container : HBoxContainer
@export var exit_button: TextureButton

var drink_buttons : Array[TextureButton]

func _ready() -> void:
	hide()
	exit_button.pressed.connect(_on_exit_button_pressed)
	
	for child in drink_hbox_container.get_children():
		drink_buttons.append(child)


func _on_exit_button_pressed():
	hide()
