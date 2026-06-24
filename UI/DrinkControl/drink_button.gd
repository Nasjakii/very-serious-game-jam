extends TextureButton

@export var infinite_drink = false
@export var label: Label

func set_infinite():
	infinite_drink = true
	label.hide()

func set_count(count : int):
	label.text = str(count)
