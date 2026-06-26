extends AudioStreamPlayer

var fade_in_time = 4

func _ready() -> void:
	finished.connect(_on_music_finished)
	fade_in()
	
	
func _on_music_finished():
	await get_tree().create_timer(5).timeout
	fade_in()
	
func fade_in():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "volume_db", -10, 3).from(-80)
	play()
