extends Control

@export var next_hint: Control
@export var hint_contents: String
@export var text_field: RichTextLabel
@export var button: TextureButton


func _ready():
	button.pressed.connect(_on_next_pressed) 
	text_field.text = hint_contents


func _on_next_pressed():
	if next_hint:
		next_hint.show()
	self.hide()
