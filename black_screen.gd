extends ColorRect

signal finished

@export var day_label: Label 
@export var start_day_button: Button

func _ready() -> void:
	start_day_button.pressed.connect(_on_start_day_button)

func fade_in(duration_secocnds : float):
	modulate.a = 0.0
	show()
	start_day_button.show()
	var tween = get_tree().create_tween()
	tween.tween_property(self, "modulate:a", 1.0, duration_secocnds).set_trans(Tween.TRANS_CUBIC)
	tween.tween_callback(finished.emit)
	
	
func fade_out(duration_secocnds : float):
	show()
	start_day_button.hide()
	modulate.a = 1.0
	var tween = get_tree().create_tween()
	tween.tween_property(self, "modulate:a", 0.0, duration_secocnds).set_trans(Tween.TRANS_CUBIC)
	tween.tween_callback(func(): 
		finished.emit()
		hide()
	)
	
func set_day(day : int):
	day_label.text = "Day: " + str(day)
	

func _on_start_day_button():
	fade_out(5)
