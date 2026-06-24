extends AudioStreamPlayer

const CLICK = preload("uid://dua7loswafptk")

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
		var randomizer = AudioStreamRandomizer.new()
		randomizer.add_stream(0, CLICK, 1)
		randomizer.random_volume_offset_db = 5
		randomizer.random_pitch_semitones = 0.1
		stream = randomizer
		play()
