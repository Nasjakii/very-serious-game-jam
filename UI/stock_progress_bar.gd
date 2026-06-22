extends ProgressBar

@export var stock_label: Label



func _on_value_changed(val: float) -> void:
	stock_label.text = str(int(floor(val)))
