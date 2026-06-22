extends HBoxContainer

var timer = 0
@export var hour_rich_text_label: RichTextLabel
@export var minute_label: Label

func _process(delta: float) -> void:
	timer += delta
	
