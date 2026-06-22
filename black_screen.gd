extends ColorRect

signal finished

@export var day_label: Label 

func fade_in(duration_secocnds : float):
	modulate.a = 0.0
	show()
	var tween = get_tree().create_tween()
	tween.tween_property(self, "modulate:a", 1.0, duration_secocnds).set_trans(Tween.TRANS_CUBIC)
	tween.tween_callback(finished.emit)
	
	
func fade_out(duration_secocnds : float):
	show()
	modulate.a = 1.0
	var tween = get_tree().create_tween()
	tween.tween_property(self, "modulate:a", 0.0, duration_secocnds).set_trans(Tween.TRANS_CUBIC)
	tween.tween_callback(func(): 
		finished.emit()
		hide()
	)
	
